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

  @Inject(LoginRepositoryTypeKey.self)
  private var repository: LoginRepositoryType

  private let tokenManager: TokenManagerType

  // MARK: - Init

  init(tokenManager: TokenManagerType) {
    self.tokenManager = tokenManager
  }

  // MARK: - Method

  func login() async throws {
    guard self.tokenManager.accessToken() != nil else {
      throw LoginTokenError.notExist
    }

    do {
      let entity = try await self.repository.login()
      self.tokenManager.save(token: entity.token)
    } catch {
      self.tokenManager.save(token: nil)
      throw error
    }
  }
}
