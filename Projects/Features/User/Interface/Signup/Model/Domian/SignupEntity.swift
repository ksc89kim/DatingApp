//
//  SignupEntity.swift
//  UserTesting
//
//  Created by kim sunchul on 11/15/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public struct SignupEntity {

  // MARK: - Property

  public let token: String

  // MARK: - Init

  public init(token: String) {
    self.token = token
  }
}
