//
//  MockTokenManager.swift
//  UserInterface
//
//  Created by kim sunchul on 10/31/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public final class MockTokenManager: TokenManagerType {

  // MARK: - Property

  private var token: String?

  // MARK: - Init

  public init(token: String? = nil) {
    self.token = token
  }

  // MARK: - Method

  public func save(token: String?) {
    self.token = token
  }
  
  public func accessToken() -> String? {
    return self.token
  }
}
