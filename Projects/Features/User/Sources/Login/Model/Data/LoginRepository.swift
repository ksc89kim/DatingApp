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

public final class LoginRepository: LoginRepositoryType {

  // MARK: - Property

  private let networking: Networking<UserAPI>

  // MARK: - Init

  public init(networking: Networking<UserAPI>) {
    self.networking = networking
  }

  // MARK: - Method
  
  public func login() async throws -> LoginEntity {
    let response = try await self.networking.request(
      LoginResponse.self,
      target: .login
    ).data
    return response.toEntity()
  }
}
