//
//  UserRegisterState.swift
//  User
//
//  Created by kim sunchul on 2/11/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation
import Util
import UserInterface

struct UserRegisterState {

  // MARK: - Property

  var currentMain: UserRegisterMain?

  var progress: UserRegisterProgressState

  var bottomButton: UserRegisterBottomButtonState

  var alert: BaseAlert

  var isPresentAlert: Bool

  var successRegister: Bool
  
  var shouldDismiss: Bool
  
  var showingImagePicker: Bool

  // MARK: - Init
  
  init(
    currentMain: UserRegisterMain? = nil,
    progress: UserRegisterProgressState = .init(),
    bottomButton: UserRegisterBottomButtonState = .init(),
    isPresentAlert: Bool = false,
    alert: BaseAlert = .empty,
    successRegister: Bool = false,
    shouldDismiss: Bool = false,
    showingImagePicker: Bool = false
  ) {
    self.currentMain = currentMain
    self.progress = progress
    self.bottomButton = bottomButton
    self.isPresentAlert = isPresentAlert
    self.alert = alert
    self.successRegister = successRegister
    self.shouldDismiss = shouldDismiss
    self.showingImagePicker = showingImagePicker
  }
}
