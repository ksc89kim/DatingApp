//
//  LaunchViewModel.swift
//  LaunchInterface
//
//  Created by kim sunchul on 2023/09/12.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import LaunchInterface
import VersionInterface
import Core
import Util

public final class LaunchViewModel: ViewModelType {

  // MARK: - Define

  enum TextConstant {
    static let retry = "재시도"
    static let confirm = "확인"
  }

  private enum TaskKey {
    static let runAfterBuild = "runAfterBuildKey"
    static let bindWorkableCompletion = "bindWorkableCompletionKey"
    static let run = "runKey"
    static let clearCount = "clearCountKey"
  }

  // MARK: - Property

  private let builder: LaunchWorkerBuildable?

  private var rootWorkable: LaunchWorkable?

  var limitRetryCount: Int = 3

  private(set) var retryCount = 0

  @Published public var state: LaunchState = .init()

  private let taskBag: AnyCancelTaskDictionaryBag = .init()

  // MARK: - Init
  
  public init(builder: LaunchWorkerBuildable?) {
    self.builder = builder
  }

  // MARK: - Trigger Methods

  public func trigger(_ action: LaunchAction) {
    switch action {
    case .run: self.run()
    case .runAfterBuildForWoker: self.runAfterBuildForWoker()
    case .clearCount: self.clearCount()
    case .buildForWorker, .runAsync, .clearCountAsync: break
    }
  }

  public func trigger(_ action: LaunchAction) async {
    switch action {
    case .buildForWorker: await self.buildForWorker()
    case .runAsync: await self.run()
    case .clearCountAsync: await self.clearCount()
    case .run, .runAfterBuildForWoker, .clearCount: break
    }
  }

  // MARK: - Private Methods

  private func runAfterBuildForWoker() {
    self.taskBag[TaskKey.runAfterBuild]?.cancel()

    Task { [weak self] in
      await self?.buildForWorker()
      await self?.run()
    }
    .store(in: self.taskBag, for: TaskKey.runAfterBuild)
  }

  private func buildForWorker() async {
    self.rootWorkable = await self.builder?.build()
    self.bindWorkableCompletion()
  }
  
  private func bindWorkableCompletion() {
    self.taskBag[TaskKey.bindWorkableCompletion]?.cancel()

    Task { [weak self] in
      await self?.rootWorkable?.completionSender?.setCompletion { [weak self] counter in
        guard let counter = counter else { return }
         self?.setCompletionCount(
          completedCount: counter.completedCount,
          totalCount: counter.totalCount
        )
      }
    }
    .store(in: self.taskBag, for: TaskKey.bindWorkableCompletion)
  }

  private func run() {
    self.taskBag[TaskKey.run]?.cancel()

    Task { [weak self] in
      await self?.run()
    }
    .store(in: self.taskBag, for: TaskKey.run)
  }

  private func run() async {
    guard self.retryCount < self.limitRetryCount,
          !(self.rootWorkable?.isComplete ?? false) else {
      return
    }
    
    do {
      if self.retryCount == 0 {
        await self.setCompletionCount(
          completedCount: 0,
          totalCount: self.rootWorkable?.totalCount ?? 0
        )
      }
      self.retryCount += 1
      try await self.rootWorkable?.run()
    } catch {
      await self.handleError(error)
    }
  }

  @MainActor
  private func setCompletionCount(completedCount: Int, totalCount: Int) {
    guard totalCount > 0 else {
      self.state.completionCountMessage = ""
      return
    }
    self.state.completionCountMessage = "\(completedCount)/\(totalCount)"
  }

  @MainActor
  private func handleError(_ error: Error) {
    if let versionError = error as? CheckVersionLaunchWorkError {
      self.handleCheckVersionError(versionError)
    } else {
      self.state.alert = self.retryAlert(message: error.localizedDescription)
    }
    self.state.isPresentAlert = true
  }

  private func handleCheckVersionError(_ error: CheckVersionLaunchWorkError) {
    switch error {
    case .needUpdate(let entity):
      self.state.alert = .init(
        title: "",
        message: entity.message,
        primaryAction: .init(
          title: TextConstant.confirm,
          type: .openURL(url: entity.linkURL),
          completion: { [weak self] in
            self?.state.isPresentAlert = false
          }
        )
      )
    case .emptyEntity:
      self.state.alert = self.retryAlert(message: error.localizedDescription)
    }
  }

  private func retryAlert(message: String) -> BaseAlert {
    return .init(
      title: "",
      message: message,
      primaryAction: .init(
        title: TextConstant.retry,
        type: .default,
        completion: { [weak self] in
          self?.state.isPresentAlert = false
          self?.run()
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
  }
}
