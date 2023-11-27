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

struct ChatHomeView: View, Injectable {

  @StateObject
  private var appState: AppState = DIContainer.resolve(
    for: AppStateKey.self
  )

  var body: some View {
    NavigationStack(path: self.$appState.chatRouter.paths) {
      ChatListView()
        .navigationDestination(for: ChatRoutePath.self) { path in
          switch path {
          case .chatRoom: Text("Test")
          }
        }
        .navigationTitle("채팅")
    }
  }
}


#Preview {
  AppStateDIRegister.register()
  return ChatHomeView()
}
