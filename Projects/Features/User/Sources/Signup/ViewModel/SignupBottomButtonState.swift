//
//  SignupBottomButtonState.swift
//  User
//
//  Created by kim sunchul on 11/16/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

struct SignupBottomButtonState {
  
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
