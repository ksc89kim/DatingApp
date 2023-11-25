//
//  ChatListView.swift
//  ChatInterface
//
//  Created by kim sunchul on 11/23/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI
import AppStateInterface

struct ChatListView: View {

  var body: some View {
    List {
      ChatChosenListRow()
    }
    .listStyle(.plain)
  }
}


#Preview {
  return ChatListView()
}
