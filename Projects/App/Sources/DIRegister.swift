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
import OnboardingInterface
import Onboarding


struct DIRegister {

  func register() {
    self.registerForAppState()
    self.registerForLaunch()
    self.registerForVersion()
    self.registerForUser()
    self.registerOnboarding()
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
        LaunchViewModel(tokenManager: TokenManager())
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
      InjectItem(VersionRepositoryTypeKey.self) {
        let repository = VersionRepository(
          networking: .init(stubClosure: Networking<VersionAPI>.immediatelyStub)
        )
        return repository
      }
      InjectItem(CheckVersionLaunchWorkerKey.self) {
        return CheckVersionLaunchWorker()
      }
    }
  }

  private func registerForUser() {
    DIContainer.register {
      InjectItem(LoginRepositoryTypeKey.self) {
        let repository = LoginRepository(
          networking: .init(stubClosure: Networking<UserAPI>.immediatelyStub)
        )
        return repository
      }
      InjectItem(LoginKey.self) {
        let tokenManager = TokenManager()
        return Login(tokenManager: tokenManager)
      }
      InjectItem(LoginLaunchWorkerKey.self) {
        let login: Loginable = DIContainer.resolve(for: LoginKey.self)
        return LoginLaunchWorker(loginable: login)
      }
    }
  }

  private func registerOnboarding() {
    DIContainer.register {
      InjectItem(OnboardingViewKey.self) {
        OnboardingView()
      }
    }
  }
}
