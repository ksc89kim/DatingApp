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
import LaunchInterface
import Launch
import VersionInterface
import Version
import AppStateInterface
import AppState
import UserInterface
import User
import OnboardingInterface
import Onboarding
import MainInterface
import Main
import ChatInterface
import Chat

struct DIRegister {

  func register() {
    AppStateDIRegister.register()
    LaunchDIRegister.register()
    MainDIRegister.register()
    OnboardingDIRegister.register()
    VersionDIRegister.register()
    UserDIRegister.register()
    self.registerChat()
  }

  private func registerChat() {
    DIContainer.register {
      InjectItem(ChatHomeViewKey.self) { ChatHomeView() }
    }
  }
}
