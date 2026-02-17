//
//  UserProfileResponse.swift
//  UserInterface
//
//  Created by kim sunchul on 2/13/26.
//

import Foundation

public struct UserProfileResponse: Codable {

  // MARK: - CodingKey

  private enum Keys: String, CodingKey {
    case userID = "user_id"
    case nickname
    case profileImages = "profile_images"
    case birthday
    case height
    case job
    case gameGenre = "game_genre"
    case introduce
    case mbti
  }

  // MARK: - Property

  public let userID: String

  public let nickname: String

  public let profileImages: [String]

  public let birthday: String

  public let height: String

  public let job: String

  public let gameGenre: [String]

  public let introduce: String

  public let mbti: String

  // MARK: - Init

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Keys.self)
    self.userID = try container.decode(String.self, forKey: .userID)
    self.nickname = try container.decode(String.self, forKey: .nickname)
    self.profileImages = try container.decodeIfPresent(
      [String].self,
      forKey: .profileImages
    ) ?? []
    self.birthday = try container.decode(String.self, forKey: .birthday)
    self.height = try container.decode(String.self, forKey: .height)
    self.job = try container.decode(String.self, forKey: .job)
    self.gameGenre = try container.decodeIfPresent(
      [String].self,
      forKey: .gameGenre
    ) ?? []
    self.introduce = try container.decodeIfPresent(
      String.self,
      forKey: .introduce
    ) ?? ""
    self.mbti = try container.decodeIfPresent(
      String.self,
      forKey: .mbti
    ) ?? ""
  }

  public init(
    userID: String,
    nickname: String,
    profileImages: [String],
    birthday: String,
    height: String,
    job: String,
    gameGenre: [String],
    introduce: String = "",
    mbti: String = ""
  ) {
    self.userID = userID
    self.nickname = nickname
    self.profileImages = profileImages
    self.birthday = birthday
    self.height = height
    self.job = job
    self.gameGenre = gameGenre
    self.introduce = introduce
    self.mbti = mbti
  }
}
