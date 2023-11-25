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
import Util

public struct ChatHomeView: View, Injectable {

  // MARK: - Property

  @StateObject var appState: AppState = DIContainer.resolve(
    for: AppStateKey.self
  )

  public var body: some View {
    NavigationStack(path: self.$appState.router.chat) {
      ChatListView()
        .navigationDestination(for: ChatRoutePath.self) { path in
          switch path {
          case .chatRoom: Text("Chat Room")
          }
        }
        .navigationTitle("채팅")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.visible, for: .navigationBar)
    }
  }

  // MARK: - Init

  public init() { }
}

#Preview {
  AppStateDIRegister.register()
  return ChatHomeView()
}
