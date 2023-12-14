//
//  SignupRepository.swift
//  UserInterface
//
//  Created by kim sunchul on 11/14/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import UserInterface
import Core

final class SignupRepository: SignupRepositoryType {

  // MARK: - Property

  private let networking: Networking<UserAPI>

  // MARK: - Init

  init(networking: Networking<UserAPI>) {
    self.networking = networking
  }

  // MARK: - Method

  func signup(request: SignupRequest) async throws -> SignupInfo {
    let response = try await self.networking.request(
      SignupResponse.self,
      target: .signup(request.paramters)
    ).data

    return response.toEntity()
  }
}
