//
//  Login.swift
//  UserInterface
//
//  Created by kim sunchul on 10/6/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import DI
import Core
import UserInterface

final class Login: Loginable {

  // MARK: - Property

  private let repository: LoginRepositoryType

  private let tokenManager: TokenManagerType

  // MARK: - Init

  init(
    repository: LoginRepositoryType,
    tokenManager: TokenManagerType
  ) {
    self.repository = repository
    self.tokenManager = tokenManager
  }

  // MARK: - Method

  func login() async throws {
    guard self.tokenManager.accessToken() != nil else {
      throw LoginTokenError.notExist
    }

    let entity = try await self.repository.login()
    self.tokenManager.save(token: entity.token)
  }
}
