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
import MainInterface
import Main
import ChatInterface
import Chat

struct DIRegister {

  func register() {
    AppStateDIRegister.register()
    LaunchDIRegister.register()
    self.registerForVersion()
    self.registerForUser()
    self.registerOnboarding()
    self.registerMain()
    self.registerChat()
  }

  private func registerForVersion() {
    DIContainer.register {
      InjectItem(VersionRepositoryTypeKey.self) {
        let repository = VersionRepository(
          networking: .init(stubClosure: Networking<VersionAPI>.immediatelyStub)
        )
        return repository
      }
      InjectItem(CheckVersionLaunchWorkerKey.self) { CheckVersionLaunchWorker() }
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
      InjectItem(SignupViewKey.self) { SignupView() }
      InjectItem(SignupViewModelKey.self) { SignupViewModel(tokenManager: TokenManager()) }
      InjectItem(SignupRepositoryTypeKey.self) {
        SignupRepository(
          networking: .init(stubClosure: Networking<UserAPI>.immediatelyStub)
        )
      }
    }
  }

  private func registerOnboarding() {
    DIContainer.register {
      InjectItem(OnboardingViewModelKey.self) { OnboardingViewModel() }
      InjectItem(OnboardingViewKey.self) { OnboardingView() }
    }
  }

  private func registerMain() {
    DIContainer.register {
      InjectItem(MainViewKey.self) { MainView() }
    }
  }

  private func registerChat() {
    DIContainer.register {
      InjectItem(ChatHomeViewKey.self) { ChatHomeView() }
    }
  }
}
