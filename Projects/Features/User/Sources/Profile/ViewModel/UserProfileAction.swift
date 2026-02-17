//
//  UserProfileAction.swift
//  User
//
//  Created by kim sunchul on 2/13/26.
//

import Foundation

public enum UserProfileAction {
  case loadProfile
  case swipeImage(index: Int)
  case like
  case skip
  case back
  case report
  case block
  case openChat
  case showMoreMenu(Bool)
  case dismissAlert
}
