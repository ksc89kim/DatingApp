//
//  SignupState.swift
//  User
//
//  Created by kim sunchul on 11/11/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import UserInterface

public struct SignupState {

  // MARK: - Property

  var currentMain: SignupMain?

  var progressValue: Double

  var isProgressViewAnimation: Bool

  var isBottmButtonDisable: Bool

  var isBottomButtonLoading: Bool

  // MARK: - Init
  
  init(
    currentMain: SignupMain? = nil,
    progressValue: Double = 0.0,
    isProgressViewAnimation: Bool = false,
    isBottmButtonDisable: Bool = false,
    isBottomButtonLoading: Bool = false
  ) {
    self.currentMain = currentMain
    self.progressValue = progressValue
    self.isProgressViewAnimation = isProgressViewAnimation
    self.isBottmButtonDisable = isBottmButtonDisable
    self.isBottomButtonLoading = isBottomButtonLoading
  }
}
