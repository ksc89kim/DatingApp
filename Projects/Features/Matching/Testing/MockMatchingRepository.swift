//
//  MockMatchingRepository.swift
//  MatchingTesting
//
//  Created by claude on 2/17/26.
//

import Foundation
import MatchingInterface

public final class MockMatchingRepository: MatchingRepositoryType {

  // MARK: - Property

  public var fetchRecommendationsResult: MatchingRecommendationResponse = .init(
    recommendations: []
  )

  public var likeResult: MatchingLikeResponse = .init(
    isMatched: false
  )

  public var fetchRecommendationsError: Error?

  public var likeError: Error?

  public var skipError: Error?

  // MARK: - Init

  public init() {}

  // MARK: - Method

  public func fetchRecommendations(page: Int) async throws
    -> MatchingRecommendationResponse {
    if let error = self.fetchRecommendationsError {
      throw error
    }
    return self.fetchRecommendationsResult
  }

  public func like(userID: String) async throws -> MatchingLikeResponse {
    if let error = self.likeError {
      throw error
    }
    return self.likeResult
  }

  public func skip(userID: String) async throws {
    if let error = self.skipError {
      throw error
    }
  }
}
