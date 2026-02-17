//
//  UserProfileRepository.swift
//  User
//
//  Created by kim sunchul on 2/13/26.
//

import Foundation
import UserInterface
import Core

final class UserProfileRepository: UserProfileRepositoryType {

  // MARK: - Property

  private let networking: Networking<UserAPI>

  // MARK: - Init

  init(networking: Networking<UserAPI>) {
    self.networking = networking
  }

  // MARK: - Method

  func fetchProfile(userID: String) async throws -> UserProfileResponse {
    return try await self.networking.request(
      UserProfileResponse.self,
      target: .profile(userID)
    ).data
  }

  func like(userID: String) async throws {
    _ = try await self.networking.request(
      EmptyResponse.self,
      target: .like(userID)
    )
  }

  func skip(userID: String) async throws {
    _ = try await self.networking.request(
      EmptyResponse.self,
      target: .skip(userID)
    )
  }

  func report(userID: String) async throws {
    _ = try await self.networking.request(
      EmptyResponse.self,
      target: .report(userID)
    )
  }

  func block(userID: String) async throws {
    _ = try await self.networking.request(
      EmptyResponse.self,
      target: .block(userID)
    )
  }
}
