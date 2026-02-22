//
//  HomeView.swift
//  Main
//
//  Created by claude on 2/21/26.
//

import SwiftUI
import DI
import AppStateInterface
import UserInterface
import Util

public struct HomeView<ProfileView: View>: View, Injectable {

  // MARK: - Property

  @StateObject
  private var viewModel: HomeViewModel = .init()

  @ObservedObject
  private var appState: AppState = DIContainer.resolve(
    for: AppStateKey.self
  )

  @ViewBuilder
  private let buildProfileView: (String, UserProfileEntryType) -> ProfileView

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
    NavigationStack(path: self.$appState.homeRouter.paths) {
      HomeDiscoverView(viewModel: self.viewModel)
        .navigationDestination(for: HomeRoutePath.self) { path in
          switch path {
          case .userProfile(let userID):
            self.buildProfileView(userID, .matchRecommend)
              .navigationBarBackButtonHidden()
          }
        }
    }
    .toolbar(
      self.appState.homeRouter.paths.isEmpty ? .visible : .hidden,
      for: .tabBar
    )
    .navigationTransition(self.appState.homeRouter.navigationTransition)
    .onAppear {
      if self.viewModel.state.cards.isEmpty {
        self.viewModel.trigger(.load)
      }
    }
  }
}
