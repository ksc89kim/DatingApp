//
//  LaunchViewModel.swift
//  LaunchInterface
//
//  Created by kim sunchul on 2023/09/12.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import VersionInterface
import LaunchInterface
import AppStateInterface
import Core
import Util
import DI
import SwiftUI

public final class LaunchViewModel: ViewModelType, Injectable {

  // MARK: - Define

  enum TextConstant {
    static let retry: LocalizedStringResource = "재시도"
    static let confirm: LocalizedStringResource = "확인"
  }

  private enum TaskKey {
    static let runAfterBuild = "runAfterBuildKey"
    static let buildForWorker = "buildForWorkerKey"
    static let run = "runKey"
    static let clearCount = "clearCountKey"
  }

  // MARK: - Property

  @Published
  public var state: LaunchState = .init()

  @Inject(LaunchWorkerBuilderKey.self)
  private var builder: LaunchWorkerBuildable?

  @Inject(AppStateKey.self)
  private var appState: AppState

  private var rootWorkable: LaunchWorkable?

  public var limitRetryCount: Int {
    get { self.retry.limit }
    set { self.retry.limit = newValue }
  }

  private(set) var retry: LaunchRetry = .init()

  private let taskBag: AnyCancelTaskDictionaryBag = .init()

  private let tokenManager: TokenManagerType?

  var isForceUpdate: Bool = false

  // MARK: - Init
  
  public init(tokenManager: TokenManagerType) {
    self.tokenManager = tokenManager
  }

  // MARK: - Trigger Methods

  public func trigger(_ action: LaunchAction) {
    switch action {
    case .run: self.run()
    case .runAfterBuildForWoker: self.runAfterBuildForWoker()
    case .clearCount: self.clearCount()
    case .checkForceUpdate: self.checkForceUpdate()
    case .buildForWorker: break
    }
  }

  func trigger(_ action: LaunchAction) async {
    switch action {
    case .buildForWorker: await self.buildForWorker()
    case .run: await self.run()
    case .clearCount: await self.clearCount()
    case .checkForceUpdate: self.checkForceUpdate()
    case .runAfterBuildForWoker: await self.runAfterBuildForWoker()
    }
  }

  // MARK: - Private Methods

  private func runAfterBuildForWoker() {
    self.taskBag[TaskKey.runAfterBuild]?.cancel()

    Task { [weak self] in
      await self?.runAfterBuildForWoker()
    }
    .store(in: self.taskBag, for: TaskKey.runAfterBuild)
  }

  private func runAfterBuildForWoker() async {
    await self.buildForWorker()
    await self.run()
  }

  private func buildForWorker() {
    self.taskBag[TaskKey.buildForWorker]?.cancel()

    Task { [weak self] in
      await self?.buildForWorker()
    }
    .store(in: self.taskBag, for: TaskKey.buildForWorker)
  }

  private func buildForWorker() async {
    self.rootWorkable = await self.builder?.build()
    await self.bindWorkableCompletion()
  }
  
  private func bindWorkableCompletion() async {
    await self.rootWorkable?.completionSender?.setCompletion { [weak self] counter in
      guard let counter = counter else { return }
       self?.setCompletionCount(
        completedCount: counter.completedCount,
        totalCount: counter.totalCount
      )
    }
  }

  private func run() {
    self.taskBag[TaskKey.run]?.cancel()

    Task { [weak self] in
      await self?.run()
    }
    .store(in: self.taskBag, for: TaskKey.run)
  }

  private func run() async {
    guard self.retry.isRetryPossible,
          !(self.rootWorkable?.isComplete ?? false) else {
      return
    }
    
    do {
      if self.retry.isNotRetry {
        await self.setCompletionCount(
          completedCount: 0,
          totalCount: self.rootWorkable?.totalCount ?? 0
        )
      }
      self.retry.add()
      try await self.rootWorkable?.run()
      await self.next()
    } catch {
      await self.handleError(error)
    }
  }

  @MainActor
  private func next() {
    self.appState.router.remove(path: MainRoutePath.launch, for: RouteKey.main)
    guard self.tokenManager?.accessToken() == nil else { return }
    self.appState.router.append(path: MainRoutePath.onboarding, for: RouteKey.main)
  }

  @MainActor
  private func handleError(_ error: Error) {
    if let versionError = error as? CheckVersionLaunchWorkError {
      self.handleCheckVersionError(versionError)
    } else {
      self.state.alert = self.makeRetryAlert(message: error.localizedDescription)
    }
    self.state.isPresentAlert = true
  }

  private func handleCheckVersionError(_ error: CheckVersionLaunchWorkError) {
    switch error {
    case .forceUpdate(let entity):
      self.state.alert = self.makeForceUpdateAlert(entity: entity)
      self.isForceUpdate = entity.isForceUpdate
    case .emptyEntity:
      self.state.alert = self.makeRetryAlert(message: error.localizedDescription)
    }
  }

  private func makeRetryAlert(message: String) -> BaseAlert {
    return .init(
      title: "",
      message: message,
      primaryAction: .init(
        title: TextConstant.retry.stringValue,
        type: .default,
        completion: { [weak self] in
          self?.state.isPresentAlert = false
          self?.run()
        }
      )
    )
  }

  private func makeForceUpdateAlert(entity: CheckVersionEntity) -> BaseAlert {
    return .init(
      title: "",
      message: entity.message,
      primaryAction: .init(
        title: TextConstant.confirm.stringValue,
        type: .openURL(url: entity.linkURL),
        completion: { [weak self] in
          self?.state.isPresentAlert = false
        }
      )
    )
  }

  private func clearCount() {
    self.taskBag[TaskKey.clearCount]?.cancel()

    Task { [weak self] in
      await self?.clearCount()
    }
    .store(in: self.taskBag, for: TaskKey.clearCount)
  }

  private func clearCount() async {
    let sender = self.rootWorkable?.completionSender
    await sender?.setCompletedCount(0)
    await sender?.setTotalCount(0)
    await self.setCompletionCount(completedCount: 0, totalCount: 0)
    self.retry.clear()
  }

  @MainActor
  private func setCompletionCount(completedCount: Int, totalCount: Int) {
    guard totalCount > 0 else {
      self.state.bottomMessage = ""
      self.state.completedCount = 0
      self.state.totalCount = 0
      return
    }
    self.state.bottomMessage = "\(completedCount)/\(totalCount)"
    self.state.completedCount = completedCount
    self.state.totalCount = totalCount
  }

  private func checkForceUpdate() {
    if self.isForceUpdate {
      self.state.isPresentAlert = true
    }
  }
}
