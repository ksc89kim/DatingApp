//
//  ChatListState.swift
//  Chat
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import ChatInterface
import Util

struct ChatListState {

  // MARK: - Property

  var isEmpty: Bool = false

  var alert: BaseAlert = .empty

  var isPresentAlert: Bool = false

  var listTitle: String = ""
  
  var messages: [ChatListMessageSectionItem] = []

  var chosenUsers: [ChatChosenSectionItem] = []
}
