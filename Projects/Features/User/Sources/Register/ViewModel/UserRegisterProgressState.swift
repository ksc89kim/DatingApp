//
//  UserRegisterProgressState.swift
//  User
//
//  Created by kim sunchul on 2/11/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation

struct UserRegisterProgressState {

  // MARK: - Property
  
  var value: Double

  var isAnimation: Bool

  // MARK: - Init

  init(
    value: Double = 0.0,
    isAnimation: Bool = false
  ) {
    self.value = value
    self.isAnimation = isAnimation
  }
}
