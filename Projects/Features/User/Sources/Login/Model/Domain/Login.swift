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
import AppStateInterface

final class Login: Loginable {

  // MARK: - Property

  private let repository: LoginRepositoryType

  @Inject(AppStateKey.self)
  private var appState: AppState

  // MARK: - Init

  init(repository: LoginRepositoryType) {
    self.repository = repository
  }

  // MARK: - Method

  func login() async throws {
    guard TokenManager.instance.accessToken() != nil else {
      throw LoginTokenError.notExist
    }

    let entity = try await self.repository.login()
    TokenManager.instance.save(token: entity.token)
    self.appState.me = entity.user
  }
}
