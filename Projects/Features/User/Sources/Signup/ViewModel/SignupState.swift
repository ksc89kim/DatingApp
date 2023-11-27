//
//  SignupState.swift
//  User
//
//  Created by kim sunchul on 11/11/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import Util
import UserInterface

struct SignupState {

  // MARK: - Property

  var currentMain: SignupMain?

  var progress: SignupProgressState

  var bottomButton: SignupBottomButtonState

  var alert: BaseAlert

  var isPresentAlert: Bool

  var successSignup: Bool

  // MARK: - Init
  
  init(
    currentMain: SignupMain? = nil,
    progress: SignupProgressState = .init(),
    bottomButton: SignupBottomButtonState = .init(),
    isPresentAlert: Bool = false,
    alert: BaseAlert = .empty,
    successSignup: Bool = false
  ) {
    self.currentMain = currentMain
    self.progress = progress
    self.bottomButton = bottomButton
    self.isPresentAlert = isPresentAlert
    self.alert = alert
    self.successSignup = successSignup
  }
}
