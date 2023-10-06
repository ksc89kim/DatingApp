//
//  LoginEntity.swift
//  User
//
//  Created by kim sunchul on 10/6/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public struct LoginEntity {

  // MARK: - Property

  public let token: String

  public let user: UserEntity

  // MARK: - Init
  
  public init(
    token: String,
    user: UserEntity
  ) {
    self.token = token
    self.user = user
  }
}
