//
//  ChatChosenUserResponse.swift
//  ChatInterface
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import ChatInterface

struct ChatChosenUserResponse: Codable {

  // MARK: - Property

  let user: ChatUserResponse
  
  let badge: Bool

  // MARK: - Method

  func toEntity() -> ChatChosenUserEntity {
    return .init(user: self.user.toEntity(), badge: badge)
  }
}
