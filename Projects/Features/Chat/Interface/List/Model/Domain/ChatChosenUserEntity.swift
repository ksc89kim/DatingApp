//
//  ChatChosenUserEntity.swift
//  ChatInterface
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public struct ChatChosenUserEntity {

  // MARK: - Property

  public let user: ChatUserEntity

  public let badge: Bool

  // MARK: - Init

  public init(user: ChatUserEntity, badge: Bool) {
    self.user = user
    self.badge = badge
  }
}
