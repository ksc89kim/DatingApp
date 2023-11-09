//
//  LaunchDelayWorker.swift
//  Launch
//
//  Created by kim sunchul on 2023/09/20.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import LaunchInterface

final class LaunchDelayWorker: LaunchWorkable {

  // MARK: - Property

  weak var parent: LaunchWorkable?

  var items: [LaunchWorkable]

  var state: LaunchWorkerState

  var sender: LaunchSendable?

  var completionSender: LaunchCompletionSender?

  private let delayTime: TimeInterval

  var nanoseconds: UInt64 {
    return UInt64(self.delayTime * 1_000_000_000)
  }

  // MARK: - Init

  init(
    delayTime: TimeInterval,
    parent: LaunchWorkable? = nil,
    items: [LaunchWorkable] = [],
    state: LaunchWorkerState = .ready,
    sender: LaunchSendable? = nil,
    completionSender: LaunchCompletionSender? = nil
  ) {
    self.parent = parent
    self.items = items
    self.state = state
    self.sender = sender
    self.completionSender = completionSender
    self.delayTime = delayTime
  }

  // MARK: - Method

  func work() async throws {
    try await Task.sleep(nanoseconds: self.nanoseconds)
  }
}
