//
//  MyPageSettingState.swift
//  MyPage
//
//  Created by kim sunchul on 2/21/26.
//

import Foundation

struct MyPageSettingState {

  // MARK: - Property

  var isMatchNotificationOn: Bool = true

  var isPresentLogoutAlert: Bool = false

  var isPresentDeleteAlert: Bool = false

  var isPresentAlert: Bool = false

  var alertMessage: String = ""

  var isLoading: Bool = false
}
