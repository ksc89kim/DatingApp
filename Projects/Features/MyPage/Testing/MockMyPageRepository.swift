//
//  MockMyPageRepository.swift
//  MyPageTesting
//
//  Created by kim sunchul on 2/19/26.
//

import Foundation
import MyPageInterface

public final class MockMyPageRepository: MyPageRepositoryType {

  // MARK: - Property

  public var fetchMyProfileResult: MyPageProfile = .init(
    userID: "test_user",
    nickname: "테스트유저",
    profileImageURLs: [],
    birthday: "1995-05-15",
    height: "170",
    job: "개발자",
    gameGenre: ["RPG"],
    introduce: "안녕하세요!",
    mbti: "INFJ"
  )

  public var updateMyProfileResult: MyPageProfile = .init(
    userID: "test_user",
    nickname: "수정된유저",
    profileImageURLs: [],
    birthday: "1995-05-15",
    height: "170",
    job: "디자이너",
    gameGenre: ["RPG"],
    introduce: "수정된 소개입니다.",
    mbti: "ENFP"
  )

  public var fetchMyProfileError: Error?

  public var updateMyProfileError: Error?

  // MARK: - Init

  public init() {}

  // MARK: - Method

  public func fetchMyProfile() async throws -> MyPageProfile {
    if let error = self.fetchMyProfileError {
      throw error
    }
    return self.fetchMyProfileResult
  }

  public func updateMyProfile(_ request: MyPageUpdateRequest) async throws -> MyPageProfile {
    if let error = self.updateMyProfileError {
      throw error
    }
    return self.updateMyProfileResult
  }
}
