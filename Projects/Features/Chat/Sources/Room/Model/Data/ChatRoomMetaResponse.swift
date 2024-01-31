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
    case partner
    case socketURL = "socket_url"
  }
  
  // MARK: - Property
  
  private let partner: ChatUserResponse
      
  private let socketURL: URL?
  
  var meta: ChatRoomMeta {
    return .init(
      partner: self.partner.chatUser,
      socketURL: self.socketURL
    )
  }
  
  // MARK: - Init
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Keys.self)
    self.partner = try container.decode(ChatUserResponse.self, forKey: .partner)
    self.socketURL = try container.decode(URL.self, forKey: .socketURL)
  }
}
