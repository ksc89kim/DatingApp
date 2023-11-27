//
//  ChatChosenResponse.swift
//  ChatInterface
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import ChatInterface

struct ChatChosenResponse: Codable {

  // MARK: - Property

  let users: [ChatChosenUserResponse]

  let page: Int

  // MARK: - Method

  func toEntity() -> ChatChosenEntity {
    let users = self.users.map { (user: ChatChosenUserResponse) -> ChatChosenUserEntity in
      return user.toEntity()
    }

    return .init(
      users: users,
      page: self.page
    )
  }
}
