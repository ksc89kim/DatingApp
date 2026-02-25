//
//  MyPageRepository.swift
//  MyPage
//
//  Created by kim sunchul on 2/19/26.
//

import Foundation
import Core
import MyPageInterface
import UserInterface

final class MyPageRepository: MyPageRepositoryType {

  // MARK: - Property

  private let networking: Networking<MyPageAPI>

  // MARK: - Init

  init(networking: Networking<MyPageAPI>) {
    self.networking = networking
  }

  // MARK: - Method

  func fetchMyProfile() async throws -> MyPageProfile {
    let response = try await self.networking.request(
      UserProfileResponse.self,
      target: .me
    ).data

    return MyPageProfile(response: response)
  }

  func updateMyProfile(_ request: MyPageUpdateRequest) async throws -> MyPageProfile {
    let encoder = JSONEncoder()
    let body = try encoder.encode(request)
    let response = try await self.networking.request(
      UserProfileResponse.self,
      target: .updateMe(body: body)
    ).data

    return MyPageProfile(response: response)
  }
}

// MARK: - MyPageProfile

private extension MyPageProfile {

  init(response: UserProfileResponse) {
    self.init(
      userID: response.userID,
      nickname: response.nickname,
      profileImageURLs: response.profileImages,
      birthday: response.birthday,
      height: response.height,
      job: response.job,
      gameGenre: response.gameGenre,
      introduce: response.introduce,
      mbti: response.mbti
    )
  }
}
