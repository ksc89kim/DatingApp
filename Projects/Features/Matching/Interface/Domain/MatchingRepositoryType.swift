//
//  MatchingRepositoryType.swift
//  MatchingInterface
//
//  Created by claude on 2/17/26.
//

import Foundation
import DI

public protocol MatchingRepositoryType: AnyObject, Injectable {

  // MARK: - Method

  func fetchRecommendations(page: Int) async throws -> MatchingRecommendationResponse

  func like(userID: String) async throws -> MatchingLikeResponse

  func skip(userID: String) async throws
}
