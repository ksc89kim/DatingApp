//
//  ChatMessages.swift
//  ChatInterface
//
//  Created by kim sunchul on 1/10/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation
import Core

public struct ChatMessages: PaginationResponse {
  
  // MARK: - Property
  
  public var isFinal: Bool
  
  public var items: [ChatMessage]
  
  // MARK: - Init
  
  public init(isFinal: Bool, messages: [ChatMessage]) {
    self.isFinal = isFinal
    self.items = messages
  }
}
