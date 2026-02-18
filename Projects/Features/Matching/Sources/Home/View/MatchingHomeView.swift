//
//  MatchingHomeView.swift
//  Matching
//
//  Created by claude on 2/17/26.
//

import SwiftUI
import DI
import AppStateInterface
import UserInterface
import Util

public struct MatchingHomeView<ProfileView: View>: View, Injectable {

  // MARK: - Property

  @ObservedObject
  private var appState: AppState = DIContainer.resolve(
    for: AppStateKey.self
  )

  @ViewBuilder
  private let buildProfileView: (
    String,
    UserProfileEntryType
  ) -> ProfileView

  // MARK: - Init

  public init(
    @ViewBuilder buildProfileView: @escaping (
      String,
      UserProfileEntryType
    ) -> ProfileView
  ) {
    self.buildProfileView = buildProfileView
  }

  // MARK: - Body

  public var body: some View {
    NavigationStack(
      path: self.$appState.matchingRouter.paths
    ) {
      MatchingCardStackView()
        .navigationDestination(
          for: MatchingRoutePath.self
        ) { path in
          switch path {
          case .userProfile(let userID):
            self.buildProfileView(
              userID,
              .matchRecommend
            )
            .navigationBarBackButtonHidden()
          }
        }
        .toolbar {
          ToolbarItem(
            placement: .navigationBarLeading
          ) {
            Text("친구")
              .foregroundStyle(.black)
              .systemScaledFont(style: .boldLargeTitle)
              .accessibilityAddTraits(.isHeader)
          }
        }
    }
    .toolbar(
      self.appState.matchingRouter.paths.isEmpty
        ? .visible : .hidden,
      for: .tabBar
    )
    .navigationTransition(
      self.appState.matchingRouter.navigationTransition
    )
  }
}


#Preview {
  AppStateDIRegister.register()
  MatchingDIRegister.register()
  return MatchingHomeView { userID, _ in
    Text("Profile: \(userID)")
  }
}
