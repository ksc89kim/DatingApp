//
//  ChatRoomMetaResponse.swift
//  Chat
//
//  Created by kim sunchul on 1/10/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation
import ChatInterface

struct ChatRoomMetaResponse: Codable {
  
  // MARK: - Define

  private enum Keys: String, CodingKey {
    case messages
    case isFinal = "is_final"
  }
  
  // MARK: - Property
  
  private let messages: [ChatMessageResponse]
  
  private let isFinal: Bool
  
  var meta: ChatRoomMeta {
    return .init(isFinal: self.isFinal, messages: self.messages.map(\.chatMessage))
  }
  
  // MARK: - Init
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Keys.self)
    self.messages = try container.decode([ChatMessageResponse].self, forKey: .messages)
    self.isFinal = try container.decode(Bool.self, forKey: .isFinal)
  }
}
