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

struct ChatHomeView: View, Injectable {

  @StateObject
  private var appState: AppState = DIContainer.resolve(
    for: AppStateKey.self
  )

  var body: some View {
    NavigationStack(path: self.$appState.chatRouter.paths) {
      VStack {
        ChatListView()
      }
      .navigationDestination(for: ChatRoutePath.self) { path in
        switch path {
        case .chatRoom: Text("")
        }
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Text("채팅")
            .systemScaledFont(style: .boldLargeTitle)
        }
      }
    }
  }
}


#Preview {
  AppStateDIRegister.register()
  ChatDIRegister.register()
  return ChatHomeView()
}
