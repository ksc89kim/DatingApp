//
//  MatchingLikeResponse.swift
//  MatchingInterface
//
//  Created by claude on 2/17/26.
//

import Foundation

public struct MatchingLikeResponse: Codable {

  // MARK: - CodingKey

  private enum Keys: String, CodingKey {
    case isMatched = "is_matched"
    case matchedUserID = "matched_user_id"
  }

  // MARK: - Property

  public let isMatched: Bool

  public let matchedUserID: String?

  // MARK: - Init

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Keys.self)
    self.isMatched = try container.decode(Bool.self, forKey: .isMatched)
    self.matchedUserID = try container.decodeIfPresent(
      String.self,
      forKey: .matchedUserID
    )
  }

  public init(isMatched: Bool, matchedUserID: String? = nil) {
    self.isMatched = isMatched
    self.matchedUserID = matchedUserID
  }
}
