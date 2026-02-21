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

  func fetchMyProfile() async throws -> UserProfileResponse {
    let response = try await self.networking.request(
      UserProfileResponse.self,
      target: .me
    ).data

    return response
  }

  func updateMyProfile(_ request: MyPageUpdateRequest) async throws -> UserProfileResponse {
    let encoder = JSONEncoder()
    let body = try encoder.encode(request)
    let response = try await self.networking.request(
      UserProfileResponse.self,
      target: .updateMe(body: body)
    ).data

    return response
  }
}
