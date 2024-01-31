//
//  ChatSocketManagerType.swift
//  ChatInterface
//
//  Created by kim sunchul on 1/16/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation
import DI

public protocol ChatSocketManagerType: Injectable {
  
  func connect(url: URL)
  
  func disconnect()
  
  func sendMessage(request: ChatMessageRequest) async throws
    
  func events() -> AsyncThrowingStream<ChatWebSocketEvent, Error>?
}
