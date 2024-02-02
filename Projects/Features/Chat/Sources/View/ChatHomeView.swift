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

  @ObservedObject
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
        case .chatRoom(let idx): ChatRoomView(roomIdx: idx)
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
  return ChatHomeView()
}
