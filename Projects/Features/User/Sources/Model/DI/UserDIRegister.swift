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
        LoginRepository(networking: .init(stub: .immediatelyStub))
      }
      InjectItem(LoginKey.self) {
        Login(tokenManager: TokenManager())
      }
      InjectItem(LoginLaunchWorkerKey.self) {
        LoginLaunchWorker(
          loginable: DIContainer.resolve(for: LoginKey.self)
        )
      }
      InjectItem(SignupViewKey.self) { SignupView() }
      InjectItem(SignupViewModelKey.self) {
        SignupViewModel(
          container: .init(index: 0, mains: [SignupNickname()]),
          tokenManager: TokenManager()
        )
      }
      InjectItem(SignupRepositoryTypeKey.self) {
        SignupRepository(
          networking: .init(stub: .immediatelyStub)
        )
      }
      InjectItem(UserRegisterRepositoryTypeKey.self) {
        UserRegisterRepository(
          networking: .init(stub: .immediatelyStub)
        )
      }
      InjectItem(UserRegisterViewModelKey.self) {
        UserRegisterViewModel(
          container: .init(
            index: 0,
            mains: [
              UserRegisterBirthday(),
              UserRegisterHeight(),
              UserRegisterSingleSelect.job,
              UserRegisterMultipleSelect.game,
              UserRegisterGallery()
            ]
          )
        )
      }
      InjectItem(UserProfileRepositoryTypeKey.self) {
        UserProfileRepository(
          networking: .init(stub: .immediatelyStub)
        )
      }

    }
  }
}
