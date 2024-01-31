//
//  ChatMessagesRequest.swift
//  ChatInterface
//
//  Created by kim sunchul on 1/10/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation

public struct ChatMessagesRequest {

  // MARK: - Property

  public let roomIdx: String

  public let messageIdx: String

  public let limit: Int
  
  // MARK: - Init

  public init(
    roomIdx: String,
    messageIdx: String,
    limit: Int
  ) {
    self.roomIdx = roomIdx
    self.messageIdx = messageIdx
    self.limit = limit
  }
}
