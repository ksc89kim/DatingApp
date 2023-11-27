//
//  SignupProgressState.swift
//  User
//
//  Created by kim sunchul on 11/16/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

struct SignupProgressState {

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
