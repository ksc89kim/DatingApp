//
//  User.swift
//  UserInterface
//
//  Created by kim sunchul on 10/6/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

struct User: Codable {
  
  // MARK: - CodingKey

  private enum Keys: String, CodingKey {
    case userID = "user_id"
  }

  // MARK: - Property

  let userID: String

  // MARK: - Init

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Keys.self)
    self.userID = try container.decode(String.self, forKey: .userID)
  }
}
