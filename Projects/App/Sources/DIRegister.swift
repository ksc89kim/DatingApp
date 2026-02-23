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
import MainInterface
import Home
import HomeInterface
import Chat
import ChatInterface
import Matching
import MatchingInterface
import MyPage
import MyPageInterface

struct DIRegister {

  func register() {
    AppStateDIRegister.register()
    LaunchDIRegister.register()
    MainDIRegister.register()
    OnboardingDIRegister.register()
    VersionDIRegister.register()
    UserDIRegister.register()
    ChatDIRegister.register()
    MatchingDIRegister.register()
    MyPageDIRegister.register()
    self.registerCrossModuleDependencies()
  }

  // MARK: - Private

  private func registerCrossModuleDependencies() {
    DIContainer.register {
      InjectItem(HomeViewKey.self) {
        HomeView { userID, entryType in
          UserProfileView(
            viewModel: UserProfileViewModel(
              userID: userID,
              entryType: entryType
            )
          )
        }
      }
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
      InjectItem(MatchingHomeViewKey.self) {
        MatchingHomeView { userID, entryType in
          UserProfileView(
            viewModel: UserProfileViewModel(
              userID: userID,
              entryType: entryType
            )
          )
        }
      }
      InjectItem(MyPageHomeViewKey.self) {
        MyPageHomeView()
      }
    }
  }
}
