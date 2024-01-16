//
//  ChatRoomState.swift
//  Chat
//
//  Created by kim sunchul on 1/8/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation

struct ChatRoomState {
  
  // MARK: - Property
  
  var items: [ChatMessageSectionItem] = []
  
  var newMessage: String = ""
  
  var scrollToBottm: Bool = false
}
