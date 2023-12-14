//
//  LoginResponse.swift
//  User
//
//  Created by kim sunchul on 10/6/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import UserInterface

struct LoginResponse: Codable {

  // MARK: - Property

  let token: String

  var info: LoginInfo {
    return .init(token: self.token)
  }
}
