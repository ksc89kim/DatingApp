//
//  ChatListView.swift
//  ChatInterface
//
//  Created by kim sunchul on 11/23/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI
import Util
import AppStateInterface
import ChatInterface
import DI

struct ChatListView: View {

  @ObservedObject
  private var viewModel: ChatListViewModel = DIContainer.resolve(
    for: ChatListViewModelKey.self
  )

  @State
  private var chosenAppearIndex: Int = 0

  // MARK: - Property

  var body: some View {
    Group {
      if self.viewModel.state.isEmpty {
        ChatListEmptyView()
      } else {
        self.listView
      }
    }
    .background(.white)
    .onAppear {
      self.viewModel.trigger(.load)
    }
    .alert(isPresented:
        .constant(self.viewModel.state.isPresentAlert)
    ) {
      self.buildAlert(self.viewModel.state.alert)
    }
  }

  @ViewBuilder
  private var listView: some View {
    List {
      self.chosenSection
      self.messageSection
    }
    .listSectionSpacing(24)
    .listStyle(.plain)
    .environment(\.defaultMinListRowHeight, 0)
  }

  @ViewBuilder
  private var chosenSection: some View {
    Section {
      ChatChosenListRowView(
        items: self.viewModel.state.chosenUsers,
        appearIndex: Binding(
          get: { self.chosenAppearIndex },
          set: { newValue in
            self.viewModel.trigger(.loadChosenListMore(index: newValue))
            self.chosenAppearIndex = newValue
          }
        )
      )
    }
    .background(.white)
    .listRowInsets(EdgeInsets())
    .listRowSeparator(.hidden)
  }

  @ViewBuilder
  private var messageSection: some View {
    Section {
      ChatListHeaderView(title: self.viewModel.state.listTitle)
      ForEach(
        self.viewModel.state.messages.enumerated().map { $0 },
        id: \.element.roomIdx
      ) { index, item in
        ChatListMessageRowView(item: item)
          .onTapGesture {
            self.viewModel.trigger(
              .presentRoom(roomIdx: item.roomIdx)
            )
          }
          .onAppear {
            self.viewModel.trigger(.loadMessageListMore(index: index))
          }
          .swipeActions(edge: .trailing) {
            Button(
              role: .destructive,
              action: {
                self.viewModel.trigger(
                  .deleteMessageRoom(roomIdx: item.roomIdx)
                )
              },
              label: {
                Label("Delete", systemImage: "trash")
              }
            )
          }
      }
    }
    .background(.white)
    .listRowInsets(EdgeInsets())
    .listRowSeparator(.hidden)
  }
}


extension ChatListView: AlertBuildable { }


#Preview {
  ChatDIRegister.register()
  return ChatListView()
}
