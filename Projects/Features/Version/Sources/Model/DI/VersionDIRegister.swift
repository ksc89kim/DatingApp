//
//  VersionDIRegister.swift
//  Version
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import DI
import Core
import VersionInterface

public struct VersionDIRegister {

  // MARK: - Method

  public static func register() {
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
}
