//
//  MatchingRepository.swift
//  Matching
//
//  Created by claude on 2/17/26.
//

import Foundation
import Core
import MatchingInterface

final class MatchingRepository: MatchingRepositoryType {

  // MARK: - Property

  private let networking: Networking<MatchingAPI>

  // MARK: - Init

  init(networking: Networking<MatchingAPI>) {
    self.networking = networking
  }

  // MARK: - Method

  func fetchRecommendations(page: Int) async throws -> MatchingRecommendationResponse {
    let response = try await self.networking.request(
      MatchingRecommendationResponse.self,
      target: .recommendations(page: page)
    ).data

    return response
  }

  func like(userID: String) async throws -> MatchingLikeResponse {
    let response = try await self.networking.request(
      MatchingLikeResponse.self,
      target: .like(userID: userID)
    ).data

    return response
  }

  func skip(userID: String) async throws {
    _ = try await self.networking.request(
      EmptyResponse.self,
      target: .skip(userID: userID)
    )
  }
}
