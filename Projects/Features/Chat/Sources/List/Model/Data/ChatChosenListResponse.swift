//
//  ChatChosenResponse.swift
//  Chat
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import ChatInterface

struct ChatChosenListResponse: Codable {

  // MARK: - Define

  private enum Keys: String, CodingKey {
    case users
    case isFinal = "is_final"
  }

  // MARK: - Property

  let users: [ChatChosenUserResponse]

  let isFinal: Bool

  // MARK: - Init

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Keys.self)
    self.users = try container.decode([ChatChosenUserResponse].self, forKey: .users)
    self.isFinal = try container.decode(Bool.self, forKey: .isFinal)
  }

  // MARK: - Method

  func toEntity() -> ChatChosenListEntity {
    let items = self.users.map { (user: ChatChosenUserResponse) -> ChatChosenUserEntity in
      return user.toEntity()
    }

    return .init(
      items: items,
      isFinal: self.isFinal
    )
  }
}