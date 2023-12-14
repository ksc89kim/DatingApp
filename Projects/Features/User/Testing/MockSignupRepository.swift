//
//  MockSignupRepository.swift
//  UserTesting
//
//  Created by kim sunchul on 11/15/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import UserInterface

final class MockSignupRepository: SignupRepositoryType {
  
  // MARK: - Property

  static let testToken = "TEST-TOKEN"

  var error: Error?

  // MARK: - Method

  func signup(request: SignupRequest) async throws -> SignupInfo {
    if let error = self.error {
      throw error
    }
    
    return .init(token: MockSignupRepository.testToken)
  }
}
