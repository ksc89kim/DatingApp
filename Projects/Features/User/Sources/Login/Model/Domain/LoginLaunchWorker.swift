//
//  LoginLaunchWorker.swift
//  User
//
//  Created by kim sunchul on 11/1/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import LaunchInterface
import UserInterface
import DI

final class LoginLaunchWorker: LaunchWorkable, Injectable {

  // MARK: - Property

  weak var parent: LaunchWorkable?
  
  var items: [LaunchWorkable] = []
  
  var state: LaunchWorkerState = .ready

  var sender: LaunchSendable?

  var completionSender: LaunchCompletionSender?

  let loginable: Loginable

  // MARK: - Init

  init(loginable: Loginable) {
    self.loginable = loginable
  }

  // MARK: - Method

  func work() async throws {
    do {
      try await self.loginable.login()
    } catch {
    }
  }
}
