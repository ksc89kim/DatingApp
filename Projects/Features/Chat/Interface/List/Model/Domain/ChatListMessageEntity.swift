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

  public let user: ChatUserEntity

  public let message: String

  public let badge: Bool

  public let isRead: Bool

  // MARK: - Init

  public init(
    user: ChatUserEntity,
    message: String,
    badge: Bool,
    isRead: Bool
  ) {
    self.user = user
    self.message = message
    self.badge = badge
    self.isRead = isRead
  }
}
