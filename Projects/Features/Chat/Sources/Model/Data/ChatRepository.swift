//
//  ChatRepository.swift
//  ChatInterface
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import Core
import ChatInterface

final class ChatRepository: ChatRepositoryType {

  // MARK: - Property

  private let networking: Networking<ChatAPI>

  // MARK: - Init

  init(networking: Networking<ChatAPI>) {
    self.networking = networking
  }

  // MARK: - Method

  func chatList() async throws -> ChatListEntity {
    let response = try await self.networking.request(
      ChatListResponse.self,
      target: .chatList
    ).data

    return response.toEntity()
  }

  func chosenList() async throws -> ChatChosenEntity {
    let response = try await self.networking.request(
      ChatChosenResponse.self,
      target: .chosenList
    ).data

    return response.toEntity()
  }
}
