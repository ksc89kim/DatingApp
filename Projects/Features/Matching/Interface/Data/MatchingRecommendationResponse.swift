//
//  MatchingRecommendationResponse.swift
//  MatchingInterface
//
//  Created by claude on 2/17/26.
//

import Foundation

public struct MatchingRecommendationResponse: Codable {

  // MARK: - CodingKey

  private enum Keys: String, CodingKey {
    case recommendations
    case hasMore = "has_more"
  }

  // MARK: - Property

  public let recommendations: [MatchingCardItem]

  public let hasMore: Bool

  // MARK: - Init

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Keys.self)
    self.recommendations = try container.decode([MatchingCardItem].self, forKey: .recommendations)
    self.hasMore = try container.decodeIfPresent(Bool.self, forKey: .hasMore) ?? false
  }

  public init(recommendations: [MatchingCardItem], hasMore: Bool = false) {
    self.recommendations = recommendations
    self.hasMore = hasMore
  }
}


public struct MatchingCardItem: Codable, Identifiable, Hashable {

  // MARK: - CodingKey

  private enum Keys: String, CodingKey {
    case userID = "user_id"
    case nickname
    case age
    case profileImages = "profile_images"
    case job
    case introduce
  }

  // MARK: - Property

  public let userID: String

  public let nickname: String

  public let age: Int

  public let profileImages: [String]

  public let job: String

  public let introduce: String

  public var id: String { self.userID }

  // MARK: - Init

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Keys.self)
    self.userID = try container.decode(String.self, forKey: .userID)
    self.nickname = try container.decode(String.self, forKey: .nickname)
    self.age = try container.decode(Int.self, forKey: .age)
    self.profileImages = try container.decodeIfPresent(
      [String].self,
      forKey: .profileImages
    ) ?? []
    self.job = try container.decode(String.self, forKey: .job)
    self.introduce = try container.decodeIfPresent(
      String.self,
      forKey: .introduce
    ) ?? ""
  }

  public init(
    userID: String,
    nickname: String,
    age: Int,
    profileImages: [String],
    job: String,
    introduce: String = ""
  ) {
    self.userID = userID
    self.nickname = nickname
    self.age = age
    self.profileImages = profileImages
    self.job = job
    self.introduce = introduce
  }
}
