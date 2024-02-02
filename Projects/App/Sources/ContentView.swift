//
//  ContentView.swift
//  FoodReviewBlog
//
//  Created by kim sunchul on 2023/10/04.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI
import DI
import LaunchInterface
import AppStateInterface
import OnboardingInterface
import UserInterface
import MainInterface
import Util

struct ContentView: View {

  // MARK: - Property

  @ObservedObject
  var appState: AppState = DIContainer.resolve(
    for: AppStateKey.self
  )

  var body: some View {
    if self.$appState.entranceRouter.paths.isEmpty {
      DIContainer.resolveView(
        for: MainViewKey.self
      )
    } else {
      NavigationStack(path: self.$appState.entranceRouter.paths) {
        EmptyView()
          .navigationDestination(for: EntranceRoutePath.self) { path in
            switch path {
            case .launch: DIContainer.resolveView(
              for: LaunchViewKey.self
            )
            .toolbar(.hidden, for: .navigationBar)
            case .onboarding: DIContainer.resolveView(
              for: OnboardingViewKey.self
            )
            .toolbar(.hidden, for: .navigationBar)
            case .signup: DIContainer.resolveView(
              for: SignupViewKey.self
            )
            .toolbar(.hidden, for: .navigationBar)
            }
          }
      }
      .navigationBarTitleDisplayMode(.inline)
      .navigationTransition(self.appState.entranceRouter.navigationTransition)
    }
  }
}


#Preview {
  AppEnvironment.bootstrap()
  return ContentView()
}
