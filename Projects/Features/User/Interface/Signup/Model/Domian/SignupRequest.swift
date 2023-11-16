//
//  SignupRequest.swift
//  UserInterface
//
//  Created by kim sunchul on 11/14/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public struct SignupRequest {

  // MARK: - Property

  public var nickname: String = ""

  public var paramters: [String: Any] {
    return [
      "nickname": self.nickname
    ]
  }

  // MARK: - Init

  public init() { }
}
