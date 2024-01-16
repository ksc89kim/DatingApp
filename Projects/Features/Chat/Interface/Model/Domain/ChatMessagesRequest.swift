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

  public let messageIdx: String

  public let limit: Int

  // MARK: - Init

  public init(messageIdx: String, limit: Int) {
    self.messageIdx = messageIdx
    self.limit = limit
  }
}
