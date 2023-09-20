//
//  LaunchRootWorker.swift
//  Launch
//
//  Created by kim sunchul on 2023/09/19.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import LaunchInterface

final class LaunchRootWorker: LaunchWorkable {

  // MARK: - Property

  var parent: LaunchWorkable?

  var items: [LaunchWorkable] = []

  var state: LaunchWorkerState = .ready

  var sender: LaunchSendable?

  var completionSender: LaunchCompletionSender? = LaunchCompletionSender()

  // MARK: - Method

  func work() async throws {
  }
}
