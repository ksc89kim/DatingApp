//
//  UserRegisterBottomButtonState.swift
//  User
//
//  Created by kim sunchul on 2/11/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation

struct UserRegisterBottomButtonState {
  
  // MARK: - Property

  var isDisable: Bool

  var isLoading: Bool

  // MARK: - Init

  init(
    isDisable: Bool = false,
    isLoading: Bool = false
  ) {
    self.isDisable = isDisable
    self.isLoading = isLoading
  }
}
