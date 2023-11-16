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
import NavigationTransitions

struct ContentView: View {

  // MARK: - Property

  @StateObject var appState: AppState = DIContainer.resolve(
    for: AppStateKey.self
  )

  var body: some View {
    NavigationStack(path: self.$appState.router.main) {
      Text("Main")
        .navigationDestination(for: MainRoutePath.self) { path in
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
    .navigationTransition(.fade(.cross))
  }
}


#Preview {
  AppEnvironment.bootstrap()
  return ContentView()
}
