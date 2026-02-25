//
//  MyPageProfile.swift
//  MyPageInterface
//
//  Created by kim sunchul on 2/25/26.
//

import Foundation

public struct MyPageProfile {

  // MARK: - Property

  public let userID: String

  public let nickname: String

  public let profileImageURLs: [String]

  public let birthday: String

  public let height: String

  public let job: String

  public let gameGenre: [String]

  public let introduce: String

  public let mbti: String

  // MARK: - Init

  public init(
    userID: String,
    nickname: String,
    profileImageURLs: [String],
    birthday: String,
    height: String,
    job: String,
    gameGenre: [String],
    introduce: String,
    mbti: String
  ) {
    self.userID = userID
    self.nickname = nickname
    self.profileImageURLs = profileImageURLs
    self.birthday = birthday
    self.height = height
    self.job = job
    self.gameGenre = gameGenre
    self.introduce = introduce
    self.mbti = mbti
  }
}
