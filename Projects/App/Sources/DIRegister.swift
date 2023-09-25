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

struct DIRegister {

  static func register() {
    DIContainer.register {
      InjectItem(LaunchViewModelKey.self) {
        return LaunchViewModel()
      }
      InjectItem(LaunchWorkerBuilderKey.self) {
        return LaunchWorkerBuilder()
      }
      InjectItem(CheckVersionLaunchWorkerKey.self) {
        let repository = VersionRepository(
          networking: .init(stubClosure: Networking<VersionAPI>.immediatelyStub)
        )
        return CheckVersionLaunchWorker(repository: repository)
      }
    }
  }
}
