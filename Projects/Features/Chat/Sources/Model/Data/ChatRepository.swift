//
//  ChatRepository.swift
//  Chat
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

  func chatList(request: ChatListRequest) async throws -> ChatListEntity {
    let response = try await self.networking.request(
      ChatListResponse.self,
      target: .chatList(page: request.page, limit: request.limit)
    ).data

    return response.toEntity()
  }

  func chosenList(request: ChatChosenListRequest) async throws -> ChatChosenListEntity {
    let response = try await self.networking.request(
      ChatChosenListResponse.self,
      target: .chosenList(page: request.page, limit: request.limit)
    ).data

    return response.toEntity()
  }

  func deleteMessage(roomIdx: String) async throws {
    _ = try await self.networking.request(
      EmptyResponse.self,
      target: .deleteMessage(roomIdx: roomIdx)
    )
  }
}
