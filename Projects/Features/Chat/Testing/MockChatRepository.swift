//
//  MockChatRepository.swift
//  ChatTesting
//
//  Created by kim sunchul on 11/28/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import ChatInterface

final class MockChatRepository: ChatRepositoryType {

  // MARK: - Define

  enum NetworkError: LocalizedError {
    case `default`
  }

  // MARK: - Property

  var isFianl: Bool = false

  var isEmpty: Bool = false

  var error: Error?
  
  private var date: Date = .now

  // MARK: - Method

  func chatList(request: ChatListRequest) async throws -> ChatList {
    guard !self.isEmpty else {
      return .init(totalCount: 100, items: [], isFinal: true)
    }

    if let error {
      throw error
    }

    let startIndex = self.startIndex(
      page: request.page,
      limit: request.limit
    )
    let endIdnex = self.endIndex(
      page: request.page,
      limit: request.limit
    )

    let items: [ChatListMessage] = (startIndex...endIdnex).map { index in
      return .init(
        roomIdx: "room.\(index)",
        user: ChatUser(
          userIdx: "user.\(index)",
          nickname: "테스트",
          thumbnail: nil
        ),
        message: "테스트\(index)",
        badge: false,
        isRead: true
      )
    }

    return .init(
      totalCount: 100,
      items: items,
      isFinal: self.isFianl
    )
  }
  
  func chosenList(request: ChatChosenListRequest) async throws -> ChatChosenList {
    guard !self.isEmpty else {
      return .init(items: [], isFinal: true)
    }

    if let error {
      throw error
    }
    
    let startIndex = self.startIndex(
      page: request.page,
      limit: request.limit
    )
    let endIdnex = self.endIndex(
      page: request.page,
      limit: request.limit
    )

    let items: [ChatChosenUser] = (startIndex...endIdnex).map { index in
      let user = ChatUser(
        userIdx: "\(index)",
        nickname: "테스트임",
        thumbnail: nil
      )
      return .init(user: user, badge: false)
    }

    return .init(items: items, isFinal: self.isFianl)
  }

  private func startIndex(page: Int, limit: Int) -> Int {
    return (page * limit) + 1
  }

  private func endIndex(page: Int, limit: Int) -> Int {
    return (page * limit) + limit
  }

  func deleteMessageRoom(roomIdx: String) async throws {
    if let error { throw error }
  }
  
  func chatRoomMeta(roomIdx: String) async throws -> ChatRoomMeta {
    if let error { throw error }
      
    return .init(
      partner: .init(
        userIdx: self.chatMessageUserIdx(isSender: false),
        nickname: "테스트",
        thumbnail: nil
      ),
      socketURL: URL(string: "ws://example.com/socket")
    )
  }
  
  func chatMessagese(request: ChatMessagesRequest) async throws -> ChatMessages {
    guard !self.isEmpty else {
      return .init(isFinal: true, messages: [])
    }
    
    if let error {
      throw error
    }
    
    self.date = self.date.addingTimeInterval(-TimeInterval(7200))
            
    let messages: [ChatMessage] = (1...30).map { index in
      let isSender: Bool = .random()
      let user = ChatUser(
        userIdx: self.chatMessageUserIdx(isSender: isSender),
        nickname: "테스트임",
        thumbnail: nil
      )
      return .init(
        messageIdx: "\(UUID())",
        user: user,
        messageKind: .text("테스트\(index)"),
        isSender: isSender,
        date: self.date.addingTimeInterval(TimeInterval(index * 100))
      )
    }
    
    return .init(isFinal: self.isFianl, messages: messages)
  }
  
  private func chatMessageUserIdx(isSender: Bool) -> String {
    return isSender ? "me" : "other"
  }
}
