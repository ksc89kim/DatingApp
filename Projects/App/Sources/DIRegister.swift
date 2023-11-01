//
//  DIRegister.swift
//  FoodReviewBlog
//
//  Created by kim sunchul on 2023/09/25.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import Core
import DI
import LaunchInterface
import Launch
import VersionInterface
import Version
import AppStateInterface
import AppState
import UserInterface
import User

struct DIRegister {

  func register() {
    self.registerForAppState()
    self.registerForLaunch()
    self.registerForVersion()
  }

  private func registerForAppState() {
    DIContainer.register {
      InjectItem(RouteInjectionKey.self) { Router() }
      InjectItem(AppStateKey.self) { AppState.instance }
    }
  }

  private func registerForLaunch() {
    DIContainer.register {
      InjectItem(LaunchViewModelKey.self) {
        LaunchViewModel()
      }
      InjectItem(LaunchWorkerBuilderKey.self) {
        LaunchWorkerBuilder()
      }
      InjectItem(LaunchViewKey.self) {
        LaunchView()
      }
    }
  }

  private func registerForVersion() {
    DIContainer.register {
      InjectItem(CheckVersionLaunchWorkerKey.self) {
        let repository = VersionRepository(
          networking: .init(stubClosure: Networking<VersionAPI>.immediatelyStub)
        )
        return CheckVersionLaunchWorker(repository: repository)
      }
    }
  }

  private func registerForUser() {
    DIContainer.register {
      InjectItem(LoginKey.self) {
        let repository = LoginRepository(
          networking: .init(stubClosure: Networking<UserAPI>.immediatelyStub)
        )
        let tokenManager = TokenManager()
        return Login(repository: repository, tokenManager: tokenManager)
      }
      InjectItem(LoginLaunchWorkerKey.self) {
        let login: Loginable = DIContainer.resolve(for: LoginKey.self)
        return LoginLaunchWorker(loginable: login)
      }
    }
  }
}
