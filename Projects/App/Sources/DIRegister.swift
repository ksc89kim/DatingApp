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
import UserInterface
import Onboarding
import Main
import Chat
import ChatInterface

struct DIRegister {

  func register() {
    AppStateDIRegister.register()
    LaunchDIRegister.register()
    MainDIRegister.register()
    OnboardingDIRegister.register()
    VersionDIRegister.register()
    UserDIRegister.register()
    ChatDIRegister.register()
    self.registerCrossModuleDependencies()
  }

  // MARK: - Private

  private func registerCrossModuleDependencies() {
    DIContainer.register {
      InjectItem(ChatHomeViewKey.self) {
        ChatHomeView { userID, entryType in
          UserProfileView(
            viewModel: UserProfileViewModel(
              userID: userID,
              entryType: entryType
            )
          )
        }
      }
    }
  }
}
