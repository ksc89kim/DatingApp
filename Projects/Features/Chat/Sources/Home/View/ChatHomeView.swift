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

public struct ChatHomeView: View, Injectable {

  @StateObject
  private var appState: AppState = DIContainer.resolve(
    for: AppStateKey.self
  )

  public var body: some View {
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

  // MARK: - Init

  public init() { }
}

#Preview {
  AppStateDIRegister.register()
  return ChatHomeView()
}
