//
//  MockLoginRepository.swift
//  UserInterface
//
//  Created by kim sunchul on 10/31/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import UserInterface

final class MockLoginRepository: LoginRepositoryType {

  // MARK: - Property

  static let testToken = "TEST-TOKEN"

  var error: Error?

  // MARK: - Method

  func login() async throws -> LoginEntity {
    if let error = self.error {
      throw error
    }
    return .init(token: MockLoginRepository.testToken)
  }
}
