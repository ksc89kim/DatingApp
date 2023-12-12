//
//  ChatListAction.swift
//  Chat
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

enum ChatListAction {
  case load
  case loadMessageList
  case loadMessageListMore(index: Int)
  case loadChosenList
  case loadChosenListMore(index: Int)
  case deleteMessage(roomIdx: String)
}
