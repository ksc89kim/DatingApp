//
//  ChatMessage.swift
//  ChatInterface
//
//  Created by kim sunchul on 1/4/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation

public struct ChatMessage: Identifiable {

  // MARK: - Property

  public let id: String

  public let user: ChatUser

  public let messageKind: ChatMessageKind

  public let isSender: Bool

  public let date: Date

  // MARK: - Init

  public init(
    messageIdx: String,
    user: ChatUser,
    messageKind: ChatMessageKind,
    isSender: Bool,
    date: Date
  ) {
    self.id = messageIdx
    self.user = user
    self.messageKind = messageKind
    self.isSender = isSender
    self.date = date
  }
}
