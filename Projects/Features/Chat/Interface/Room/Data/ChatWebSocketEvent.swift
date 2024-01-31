//
//  ChatWebSocketEvent.swift
//  ChatInterface
//
//  Created by kim sunchul on 1/21/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation

public enum ChatWebSocketEvent {
  case connected
  case message(ChatMessage)
  case error(Error)
}
