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

  func chatList(request: ChatListRequest) async throws -> ChatList {
    let response = try await self.networking.request(
      ChatListResponse.self,
      target: .chatList(page: request.page, limit: request.limit)
    ).data

    return response.chatMessageList
  }

  func chosenList(request: ChatChosenListRequest) async throws -> ChatChosenList {
    let response = try await self.networking.request(
      ChatChosenListResponse.self,
      target: .chosenList(page: request.page, limit: request.limit)
    ).data

    return response.chatChosenList
  }

  func deleteMessageRoom(roomIdx: String) async throws {
    _ = try await self.networking.request(
      EmptyResponse.self,
      target: .deleteMessageRoom(roomIdx: roomIdx)
    )
  }
  
  func chatRoomMeta(roomIdx: String) async throws -> ChatRoomMeta {
    let response = try await self.networking.request(
      ChatRoomMetaResponse.self,
      target: .chatRoomMeta(roomIdx: roomIdx)
    ).data
    
    return response.meta
  }
  
  func chatMessagese(request: ChatMessagesRequest) async throws -> ChatMessages {
    let response = try await self.networking.request(
      ChatMessagesResponse.self,
      target: .chatMessages(lastID: request.messageIdx, limit: request.limit)
    ).data
    
    return response.chatMessages
  }
}
