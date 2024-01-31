//
//  ChatMessageResponse.swift
//  Chat
//
//  Created by kim sunchul on 1/10/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation
import ChatInterface

struct ChatMessageResponse: Codable {
  
  // MARK: - Define
  
  private enum Keys: String, CodingKey {
    case messageIdx = "message_idx"
    case user
    case messageKind = "message_kind"
    case isSender = "is_sender"
    case date = "date"
  }
  
  // MARK: - Property
  
  private let messageIdx: String
  
  private let user: ChatUserResponse
  
  private let messageKind: ChatMessageKindResponse
  
  private let isSender: Bool
  
  private let date: Date
  
  var chatMessage: ChatMessage {
    return .init(
      messageIdx: self.messageIdx,
      user: self.user.chatUser,
      messageKind: self.messageKind.kind,
      isSender: self.isSender,
      date: self.date
    )
  }
  
  // MARK: - Init
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Keys.self)
    self.messageIdx = try container.decode(String.self, forKey: .messageIdx)
    self.user = try container.decode(ChatUserResponse.self, forKey: .user)
    self.messageKind = try container.decode(ChatMessageKindResponse.self, forKey: .messageKind)
    self.isSender = try container.decode(Bool.self, forKey: .isSender)
    let dateString = try container.decode(String.self, forKey: .date)
    self.date = ChatDate.date(from: dateString) ?? .now
  }
}
