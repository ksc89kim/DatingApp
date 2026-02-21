//
//  MyPageAction.swift
//  MyPage
//
//  Created by kim sunchul on 2/19/26.
//

import Foundation

enum MyPageAction {
  case loadProfile
  case navigateToEdit
  case navigateToSetting
  case selectImagePage(index: Int)
  case dismissAlert
  case selectCompletionTip(id: String)
  case purchaseSuperLike
  case purchaseBoost
  case upgradeSubscription
}
