//
//  ChatHomeView.swift
//  Chat
//
//  Created by kim sunchul on 11/24/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI
import DI

public struct ChatHomeView: View, Injectable {

  public var body: some View {
    ChatListView()
  }

  // MARK: - Init

  public init() { }
}

#Preview {
  return ChatHomeView()
}
