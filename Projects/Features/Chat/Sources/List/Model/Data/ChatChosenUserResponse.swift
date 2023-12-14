//
//  ChatChosenUserResponse.swift
//  Chat
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import ChatInterface

struct ChatChosenUserResponse: Codable {

  // MARK: - Property

  private let user: ChatUserResponse

  private let badge: Bool

  var chosenUser: ChatChosenUser {
    return .init(user: self.user.chatUser, badge: self.badge)
  }
}
