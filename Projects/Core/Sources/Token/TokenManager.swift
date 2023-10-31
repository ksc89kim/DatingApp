//
//  TokenManager.swift
//  Core
//
//  Created by kim sunchul on 10/6/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public final class TokenManager: TokenManagerType {

  // MARK: - Property

  private static let Key = "access_token"

  // MARK: - Method

  public func save(token: String) {
    UserDefaults.standard.setValue(token, forKey: TokenManager.Key)
  }

  public func accessToken() -> String? {
    return UserDefaults.standard.string(forKey: TokenManager.Key)
  }
}
