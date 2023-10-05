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
}
