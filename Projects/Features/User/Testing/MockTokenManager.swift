//
//  MockTokenManager.swift
//  UserInterface
//
//  Created by kim sunchul on 10/31/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import Core

final class MockTokenManager: TokenManagerType {

  // MARK: - Property

  private var token: String?

  // MARK: - Method

  func save(token: String?) {
    self.token = token
  }
  
  func accessToken() -> String? {
    return self.token
  }
}
