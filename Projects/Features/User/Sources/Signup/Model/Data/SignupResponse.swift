//
//  SignupResponse.swift
//  UserTesting
//
//  Created by kim sunchul on 11/15/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import UserInterface

struct SignupResponse: Codable {

  // MARK: - Property

  let token: String

  // MARK: - Method

  func toEntity() -> SignupInfo {
    return .init(token: self.token)
  }
}
