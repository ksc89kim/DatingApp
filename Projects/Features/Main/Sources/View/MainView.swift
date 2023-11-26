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

public struct MainView: View, Injectable {

  // MARK: - Property

  @State var isAnimation: Bool = false

  public var body: some View {
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
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .tint(UtilAsset.MainColor.background.swiftUIColor)
    .transition(.opacity.animation(.easeInOut(duration: 0.2)))
  }

  // MARK: - Init

  public init() { }
}


#Preview {
  DIContainer.register {
    InjectItem(ChatHomeViewKey.self) {
      AnyView(Text("Chat List"))
    }
  }
  return MainView()
}
