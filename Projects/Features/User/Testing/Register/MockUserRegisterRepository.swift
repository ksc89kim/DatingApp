//
//  MockUserRegisterRepository.swift
//  UserTesting
//
//  Created by kim sunchul on 2/13/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation
import UserInterface

final class MockUserRegisterRepository: UserRegisterRepositoryType {

  // MARK: - Property

  var error: Error?

  // MARK: - Method
  
  func register(request: UserRegisterRequest) async throws {
    if let error = self.error {
      throw error
    }
  }
}
