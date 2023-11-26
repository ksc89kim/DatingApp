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
      Section {
        ChatChosenListRowView()
      }
      .listRowInsets(EdgeInsets())
      .listRowSeparator(.hidden)
      Section {
        ChatListHeaderView()
        ForEach(1...100, id: \.self) { _ in
          ChatListRowView()
            .swipeActions(edge: .trailing) {
              Button(
                role: .destructive,
                action: { },
                label: {
                  Label("Delete", systemImage: "trash")
                }
              )
            }
        }
      }
      .listRowInsets(EdgeInsets())
      .listRowSeparator(.hidden)
    }
    .listSectionSpacing(24)
    .listStyle(.plain)
    .environment(\.defaultMinListRowHeight, 0)
  }
}


#Preview {
  return ChatListView()
}
