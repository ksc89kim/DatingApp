//
//  DIRegister.swift
//  FoodReviewBlog
//
//  Created by kim sunchul on 2023/09/25.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import Core
import DI
import Launch
import Version
import AppStateInterface
import User
import Onboarding
import Main
import Chat

struct DIRegister {

  func register() {
    AppStateDIRegister.register()
    LaunchDIRegister.register()
    MainDIRegister.register()
    OnboardingDIRegister.register()
    VersionDIRegister.register()
    UserDIRegister.register()
    ChatDIRegister.register()
  }
}
