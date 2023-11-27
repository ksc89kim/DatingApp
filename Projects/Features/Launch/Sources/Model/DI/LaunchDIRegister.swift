//
//  LaunchDIRegister.swift
//  LaunchInterface
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import DI
import LaunchInterface
import Core

public struct LaunchDIRegister {

  // MARK: - Method
  
  public static func register() {
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
}
