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

struct DIRegister {

  static func register() {

    // MARK: - AppState

    DIContainer.register {
      InjectItem(AppStateKey.self) { AppState.instance }
    }

    // MARK: - Launch

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

    // MARK: - Version

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
