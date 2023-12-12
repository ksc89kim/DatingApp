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

  let roomIdx: String

  let user: ChatUserResponse

  let badge: Bool

  let message: String

  let isRead: Bool

  // MARK: - Init

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Keys.self)
    self.roomIdx = try container.decode(String.self, forKey: .roomIdx)
    self.user = try container.decode(ChatUserResponse.self, forKey: .user)
    self.badge = try container.decode(Bool.self, forKey: .badge)
    self.message = try container.decode(String.self, forKey: .message)
    self.isRead = try container.decode(Bool.self, forKey: .isRead)
  }

  // MARK: - Method

  func toEntity() -> ChatListMessageEntity {
    return .init(
      roomIdx: self.roomIdx,
      user: self.user.toEntity(),
      message: self.message,
      badge: self.badge,
      isRead: self.isRead
    )
  }
}
