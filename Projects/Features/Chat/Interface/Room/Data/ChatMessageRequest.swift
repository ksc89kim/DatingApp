//
//  ChatMessageRequest.swift
//  ChatInterface
//
//  Created by kim sunchul on 1/20/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation

public struct ChatMessageRequest: Codable {
  
  // MARK: - Property
  
  public let message: String
  
  public let userIdx: String
    
  // MARK: - Init
  
  public init(message: String, userIdx: String) {
    self.message = message
    self.userIdx = userIdx
  }
}
