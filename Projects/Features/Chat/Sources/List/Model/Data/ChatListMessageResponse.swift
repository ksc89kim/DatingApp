//
//  ChatListMessageResponse.swift
//  Chat
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import ChatInterface

struct ChatListMessageResponse: Codable {

  // MARK: - Define

  private enum Keys: String, CodingKey {
    case roomIdx = "room_idx"
    case user
    case badge
    case message
    case isRead = "is_read"
  }

  // MARK: - Property

  private let roomIdx: String

  private let user: ChatUserResponse

  private let badge: Bool

  private let message: String

  private let isRead: Bool

  var chatMessage: ChatListMessage {
    return .init(
      roomIdx: self.roomIdx,
      user: self.user.chatUser,
      message: self.message,
      badge: self.badge,
      isRead: self.isRead
    )
  }

  // MARK: - Init

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Keys.self)
    self.roomIdx = try container.decode(String.self, forKey: .roomIdx)
    self.user = try container.decode(ChatUserResponse.self, forKey: .user)
    self.badge = try container.decode(Bool.self, forKey: .badge)
    self.message = try container.decode(String.self, forKey: .message)
    self.isRead = try container.decode(Bool.self, forKey: .isRead)
  }
}
