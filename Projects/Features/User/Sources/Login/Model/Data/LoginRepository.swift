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

  private let network: Networking<UserAPI>

  // MARK: - Init

  init(network: Networking<UserAPI>) {
    self.network = network
  }

  // MARK: - Method
  
  func login() async throws -> LoginEntity {
    let response = try await self.network.request(
      LoginResponse.self,
      target: .login
    ).data
    return response.toEntity()
  }
}
