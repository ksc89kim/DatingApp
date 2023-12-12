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

  // MARK: - Method

  func chatList(request: ChatListRequest) async throws -> ChatListEntity {
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

    let items: [ChatListMessageEntity] = (startIndex...endIdnex).map { index in
      return .init(
        roomIdx: "room.\(index)",
        user: ChatUserEntity(
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
  
  func chosenList(request: ChatChosenListRequest) async throws -> ChatChosenListEntity {
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

    let items: [ChatChosenUserEntity] = (startIndex...endIdnex).map { index in
      let user = ChatUserEntity(
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

  func deleteMessage(roomIdx: String) async throws {
    if let error {
      throw error
    }
  }
}
