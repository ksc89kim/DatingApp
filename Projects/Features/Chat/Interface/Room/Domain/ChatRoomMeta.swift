//
//  ChatRoomMeta.swift
//  ChatInterface
//
//  Created by kim sunchul on 1/10/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation

public struct ChatRoomMeta {
  
  // MARK: - Property
  
  public let isFinal: Bool
  
  public let messages: [ChatMessage]
  
  // MARK: - Init
  
  public init(isFinal: Bool, messages: [ChatMessage]) {
    self.isFinal = isFinal
    self.messages = messages
  }
}
