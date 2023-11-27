//
//  ChatListEntity.swift
//  ChatInterface
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public struct ChatListEntity {

  // MARK: - Property

  public let page: Int

  public let count: Int

  public let messages: [ChatListMessageEntity]

  // MARK: - Init
  
  public init(
    page: Int,
    count: Int,
    messages: [ChatListMessageEntity]
  ) {
    self.page = page
    self.count = count
    self.messages = messages
  }
}
