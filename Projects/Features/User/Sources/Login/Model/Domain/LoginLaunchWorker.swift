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

public final class LoginLaunchWorker: LaunchWorkable, Injectable {

  // MARK: - Property

  public var parent: LaunchWorkable?
  
  public var items: [LaunchWorkable] = []
  
  public var state: LaunchWorkerState = .ready

  public var sender: LaunchSendable?

  public var completionSender: LaunchCompletionSender?

  private let loginable: Loginable

  // MARK: - Init

  public init(loginable: Loginable) {
    self.loginable = loginable
  }

  // MARK: - Method

  public func work() async throws {
    do {
      try await self.loginable.login()
    } catch {

    }
  }
}
