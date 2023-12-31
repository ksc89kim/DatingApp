//
//  ChatListResponse.swift
//  Chat
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import ChatInterface

struct ChatListResponse: Codable {

  // MARK: - Define

  private enum Keys: String, CodingKey {
    case totalCount = "total_count"
    case messages
    case isFinal = "is_final"
  }

  // MARK: - Property

  private let messages: [ChatListMessageResponse]

  private let totalCount: Int

  private let isFinal: Bool

  var chatMessageList: ChatList {
    return .init(
      totalCount: self.totalCount,
      items: self.messages.map(\.chatMessage),
      isFinal: self.isFinal
    )
  }

  // MARK: - Init

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Keys.self)
    self.totalCount = try container.decode(Int.self, forKey: .totalCount)
    self.messages = try container.decode([ChatListMessageResponse].self, forKey: .messages)
    self.isFinal = try container.decode(Bool.self, forKey: .isFinal)
  }
}
