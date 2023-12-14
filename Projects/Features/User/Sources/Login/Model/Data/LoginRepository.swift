//
//  LoginRepository.swift
//  UserInterface
//
//  Created by kim sunchul on 10/6/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import UserInterface
import Core

final class LoginRepository: LoginRepositoryType {

  // MARK: - Property

  private let networking: Networking<UserAPI>

  // MARK: - Init

  init(networking: Networking<UserAPI>) {
    self.networking = networking
  }

  // MARK: - Method
  
  func login() async throws -> LoginInfo {
    let response = try await self.networking.request(
      LoginResponse.self,
      target: .login
    ).data
    return response.info
  }
}
