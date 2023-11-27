//
//  UserDIRegister.swift
//  UserInterface
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import DI
import Core
import UserInterface

public struct UserDIRegister {

  // MARK: - Method

  public static func register() {
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
}
