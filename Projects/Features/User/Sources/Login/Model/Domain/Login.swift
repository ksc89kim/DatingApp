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

public final class Login: Loginable, Injectable {

  // MARK: - Property

  private let repository: LoginRepositoryType

  private let tokenManager: TokenManagerType

  // MARK: - Init

  public init(
    repository: LoginRepositoryType,
    tokenManager: TokenManagerType
  ) {
    self.repository = repository
    self.tokenManager = tokenManager
  }

  // MARK: - Method

  public func login() async throws {
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
