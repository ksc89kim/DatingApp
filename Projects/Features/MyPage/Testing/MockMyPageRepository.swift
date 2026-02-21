//
//  MockMyPageRepository.swift
//  MyPageTesting
//
//  Created by kim sunchul on 2/19/26.
//

import Foundation
import MyPageInterface
import UserInterface

public final class MockMyPageRepository: MyPageRepositoryType {

  // MARK: - Property

  public var fetchMyProfileResult: UserProfileResponse = .init(
    userID: "test_user",
    nickname: "테스트유저",
    profileImages: [],
    birthday: "1995-05-15",
    height: "170",
    job: "개발자",
    gameGenre: ["RPG"],
    introduce: "안녕하세요!",
    mbti: "INFJ"
  )

  public var updateMyProfileResult: UserProfileResponse = .init(
    userID: "test_user",
    nickname: "수정된유저",
    profileImages: [],
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

  public func fetchMyProfile() async throws -> UserProfileResponse {
    if let error = self.fetchMyProfileError {
      throw error
    }
    return self.fetchMyProfileResult
  }

  public func updateMyProfile(_ request: MyPageUpdateRequest) async throws -> UserProfileResponse {
    if let error = self.updateMyProfileError {
      throw error
    }
    return self.updateMyProfileResult
  }
}
