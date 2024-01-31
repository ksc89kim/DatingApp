//
//  ChatRoomAction.swift
//  Chat
//
//  Created by kim sunchul on 1/8/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation

enum ChatRoomAction {
  case loadRoomInfo(roomIdx: String)
  case sendMessage
  case loadMoreMessages(index: Int)
}
