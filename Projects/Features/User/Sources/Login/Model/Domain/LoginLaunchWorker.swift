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

final class LoginLaunchWorker: LaunchWorkable {
  
  // MARK: - Property

  var parent: LaunchWorkable?
  
  var items: [LaunchWorkable] = []
  
  var state: LaunchWorkerState = .ready

  var sender: LaunchSendable?
  
  var completionSender: LaunchCompletionSender?

  private let loginable: Loginable

  // MARK: - Init

  public init(loginable: Loginable) {
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
