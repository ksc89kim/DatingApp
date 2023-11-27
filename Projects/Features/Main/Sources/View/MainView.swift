//
//  MainView.swift
//  MainInterface
//
//  Created by kim sunchul on 11/23/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI
@testable import Util
@testable import DI
@testable import ChatInterface

struct MainView: View, Injectable {

  // MARK: - Property

  var body: some View {
    TabView {
      Text("Home")
        .tabItem {
          Label("홈", systemImage: "house")
        }
      Text("Friend")
        .tabItem {
          Label("친구", systemImage: "heart")
        }
      DIContainer.resolveView(for: ChatHomeViewKey.self)
        .tabItem {
          Label("채팅", systemImage: "message")
        }
      Text("My")
        .tabItem {
          Label("MY", systemImage: "person")
        }
    }
    .tint(UtilAsset.MainColor.background.swiftUIColor)
    .transition(.opacity.animation(.easeInOut(duration: 0.2)))
    .onAppear {
      UITabBar.appearance().shadowImage = UIImage()
      UITabBar.appearance().backgroundImage = UIImage()
      UITabBar.appearance().backgroundColor = UIColor.white
    }
  }
}


#Preview {
  DIContainer.register {
    InjectItem(ChatHomeViewKey.self) {
      AnyView(Text("Chat List"))
    }
  }
  return MainView()
}
