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

public final class LaunchViewModel: ObservableObject {

  // MARK: - Define

  enum TextConstant {
    static let retry = "재시도"
    static let confirm = "확인"
  }

  enum Constant {
    static let limitRetry = 3
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

  private(set) var alert: LaunchAlert = .empty

  private(set) var retryCount = 0

  @Published var completionCount: String = ""

  @Published var isPresentAlert: Bool = false

  private let taskBag: AnyCancelTaskDictionaryBag = .init()

  // MARK: - Init
  
  public init(builder: LaunchWorkerBuildable?) {
    self.builder = builder
  }

  // MARK: - Methods

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

  func runAfterBuild() {
    self.taskBag[TaskKey.runAfterBuild]?.cancel()

    Task { [weak self] in
      await self?.build()
      await self?.run()
    }
    .store(in: self.taskBag, for: TaskKey.runAfterBuild)
  }

  func build() async {
    self.rootWorkable = await self.builder?.build()
    self.bindWorkableCompletion()
  }

  func run() {
    self.taskBag[TaskKey.run]?.cancel()

    Task { [weak self] in
      await self?.run()
    }
    .store(in: self.taskBag, for: TaskKey.run)
  }

  func run() async {
    guard self.retryCount < Constant.limitRetry,
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
      self.completionCount = ""
      return
    }
    self.completionCount = "\(completedCount)/\(totalCount)"
  }

  @MainActor
  private func handleError(_ error: Error) {
    if let versionError = error as? CheckVersionLaunchWorkError {
      self.handleCheckVersionError(versionError)
    } else {
      self.alert = self.retryAlert(message: error.localizedDescription)
    }
    self.isPresentAlert = true
  }

  private func handleCheckVersionError(_ error: CheckVersionLaunchWorkError) {
    switch error {
    case .needUpdate(let entity):
      self.alert = .init(
        title: "",
        message: entity.message,
        primaryAction: .init(
          title: TextConstant.confirm,
          type: .openURL(url: entity.linkURL),
          completion: { [weak self] in
            self?.alert = .empty
          }
        )
      )
    case .emptyEntity:
      self.alert = self.retryAlert(message: error.localizedDescription)
    }
  }

  private func retryAlert(message: String) -> LaunchAlert {
    return .init(
      title: "",
      message: message,
      primaryAction: .init(
        title: TextConstant.retry,
        type: .default,
        completion: {
          self.alert = .empty
          self.run()
        }
      )
    )
  }

  func clearCount() {
    self.taskBag[TaskKey.clearCount]?.cancel()
    
    Task { [weak self] in
      self?.clearCount
    }
    .store(in: self.taskBag, for: TaskKey.clearCount)
  }

  private func clearCount() async {
    let sender = self.rootWorkable?.completionSender
    await sender?.setCompletedCount(0)
    await sender?.setTotalCount(0)
  }
}
