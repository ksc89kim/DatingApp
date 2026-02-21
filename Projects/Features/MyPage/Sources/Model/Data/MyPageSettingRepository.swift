//
//  MyPageSettingRepository.swift
//  MyPage
//
//  Created by kim sunchul on 2/21/26.
//

import Foundation
import Core
import MyPageInterface

final class MyPageSettingRepository: MyPageSettingRepositoryType {

  // MARK: - Property

  private let networking: Networking<MyPageSettingAPI>

  // MARK: - Init

  init(networking: Networking<MyPageSettingAPI>) {
    self.networking = networking
  }

  // MARK: - Method

  func logout() async throws {
    _ = try await self.networking.request(
      EmptyResponse.self,
      target: .logout
    )
    TokenManager().save(token: nil)
  }

  func deleteAccount() async throws {
    _ = try await self.networking.request(
      EmptyResponse.self,
      target: .deleteAccount
    )
    TokenManager().save(token: nil)
  }
}
