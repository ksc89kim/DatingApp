//
//  MainView.swift
//  MainInterface
//
//  Created by kim sunchul on 11/23/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI
import Util
import DI

public struct MainView: View, Injectable {

  // MARK: - Property

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
      Text("Chat")
        .tabItem {
          Label("채팅", systemImage: "message")
        }
      Text("My")
        .tabItem {
          Label("MY", systemImage: "person")
        }
    }
    .tint(UtilAsset.MainColor.background.swiftUIColor)
  }

  // MARK: - Init

  public init() { }
}


#Preview {
  MainView()
}
