//
//  ChatListMessageEntity.swift
//  ChatInterface
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public struct ChatListMessageEntity {

  // MARK: - Property

  public let roomIdx: String

  public let user: ChatUserEntity

  public let message: String

  public let badge: Bool

  public let isRead: Bool

  // MARK: - Init

  public init(
    roomIdx: String,
    user: ChatUserEntity,
    message: String,
    badge: Bool,
    isRead: Bool
  ) {
    self.roomIdx = roomIdx
    self.user = user
    self.message = message
    self.badge = badge
    self.isRead = isRead
  }
}
