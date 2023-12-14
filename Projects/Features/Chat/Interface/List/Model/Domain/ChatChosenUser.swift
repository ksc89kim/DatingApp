//
//  ChatChosenUser.swift
//  ChatInterface
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public struct ChatChosenUser {

  // MARK: - Property

  public let user: ChatUser

  public let badge: Bool

  // MARK: - Init

  public init(user: ChatUser, badge: Bool) {
    self.user = user
    self.badge = badge
  }
}
