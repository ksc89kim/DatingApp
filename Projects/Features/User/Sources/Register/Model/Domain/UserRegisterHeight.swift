//
//  UserRegisterHeight.swift
//  User
//
//  Created by kim sunchul on 2/13/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation
import UserInterface

final class UserRegisterHeight: UserRegisterMain {
  
  // MARK: - Property
  
  var height: String
  
  var isBottomDisable: Bool = false
  
  weak var repository: UserRegisterRepositoryType?
  
  // MARK: - Init
  
  init(height: String = "165cm") {
    self.height = height
  }
  
  // MARK: - Method
  
  func mergeRequest(_ request: UserRegisterRequest) -> UserRegisterRequest {
    var request = request
    request.height = self.height
    return request
  }
  
  func updateHeight(_ height: String) {
    self.height = height
  }
}
