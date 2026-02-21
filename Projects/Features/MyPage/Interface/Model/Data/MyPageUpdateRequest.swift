//
//  MyPageUpdateRequest.swift
//  MyPageInterface
//
//  Created by kim sunchul on 2/19/26.
//

import Foundation

public struct MyPageUpdateRequest: Encodable {

  // MARK: - CodingKey

  private enum Keys: String, CodingKey {
    case nickname
    case introduce
    case height
    case job
    case gameGenre = "game_genre"
    case mbti
  }

  // MARK: - Property

  public let nickname: String

  public let introduce: String

  public let height: String

  public let job: String

  public let gameGenre: [String]

  public let mbti: String

  // MARK: - Init

  public init(
    nickname: String,
    introduce: String,
    height: String,
    job: String,
    gameGenre: [String],
    mbti: String
  ) {
    self.nickname = nickname
    self.introduce = introduce
    self.height = height
    self.job = job
    self.gameGenre = gameGenre
    self.mbti = mbti
  }

  // MARK: - Method

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: Keys.self)
    try container.encode(self.nickname, forKey: .nickname)
    try container.encode(self.introduce, forKey: .introduce)
    try container.encode(self.height, forKey: .height)
    try container.encode(self.job, forKey: .job)
    try container.encode(self.gameGenre, forKey: .gameGenre)
    try container.encode(self.mbti, forKey: .mbti)
  }
}
