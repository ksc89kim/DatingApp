//
//  ChatHomeView.swift
//  Chat
//
//  Created by kim sunchul on 11/24/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI
import DI
import AppStateInterface
import UserInterface
import Util

public struct ChatHomeView<ProfileView: View>: View, Injectable {

  // MARK: - Property

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
    NavigationStack(path: self.$appState.chatRouter.paths) {
      VStack {
        ChatListView()
      }
      .navigationDestination(for: ChatRoutePath.self) { path in
        switch path {
        case .chatRoom(let idx):
          ChatRoomView(roomIdx: idx)
            .toolbar(.hidden, for: .tabBar)
            .navigationBarBackButtonHidden()
        case .userProfile(let userID):
          self.buildProfileView(userID, .chatList)
            .toolbar(.hidden, for: .tabBar)
            .navigationBarBackButtonHidden()
        }
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Text("채팅")
            .foregroundStyle(.black)
            .systemScaledFont(style: .boldLargeTitle)
            .accessibilityAddTraits(.isHeader)
        }
      }
    }
  }
}


#Preview {
  AppStateDIRegister.register()
  ChatDIRegister.register()
  return ChatHomeView { userID, _ in
    Text("Profile: \(userID)")
  }
}
