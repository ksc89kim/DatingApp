//
//  LoginInfo.swift
//  User
//
//  Created by kim sunchul on 10/6/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public struct LoginInfo {

  // MARK: - Property

  public let token: String

  // MARK: - Init
  
  public init(token: String) {
    self.token = token
  }
}
