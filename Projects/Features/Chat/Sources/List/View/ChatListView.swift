//
//  ChatListView.swift
//  ChatInterface
//
//  Created by kim sunchul on 11/23/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI
import DI
import AppStateInterface

public struct ChatListView: View, Injectable {

  // MARK: - Property

  @StateObject var appState: AppState = DIContainer.resolve(
    for: AppStateKey.self
  )

  public var body: some View {
    NavigationStack(path: self.$appState.router.chat) {
      Text("Chat List")
        .navigationDestination(for: ChatRoutePath.self) { path in
          switch path {
          case .chatRoom: Text("Chat Room")
          }
        }
    }
    .navigationBarTitleDisplayMode(.inline)
  }

  // MARK: - Init

  public init() { }
}


#Preview {
  AppStateDIRegister.register()
  return ChatListView()
}
