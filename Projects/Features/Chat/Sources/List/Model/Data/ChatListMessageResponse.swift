//
//  ChatListMessageResponse.swift
//  ChatInterface
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import ChatInterface

struct ChatListMessageResponse: Codable {

  // MARK: - Property

  let user: ChatUserResponse

  let badge: Bool

  let message: String

  let isRead: Bool

  // MARK: - Method

  func toEntity() -> ChatListMessageEntity {
    return .init(
      user: self.user.toEntity(),
      message: self.message,
      badge: self.badge,
      isRead: self.isRead
    )
  }
}
