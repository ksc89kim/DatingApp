//
//  ChatRoomMessageListView.swift
//  Chat
//
//  Created by kim sunchul on 1/4/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import SwiftUI
import ChatInterface

struct ChatRoomMessageListView: View {
  
  // MARK: - Define
  
  enum Constant {
    static let bottomID = "Bottom"
  }
  
  // MARK: - Property
  
  @Binding
  var messages: [ChatMessageSectionItem]
  
  @Binding
  var scrollToBottom: Bool
  
  @Binding
  var appearIndex: Int
  
  var body: some View {
    ScrollViewReader { proxy in
      List {
        Section {
          Spacer()
            .frame(height: 14)
            .id(Constant.bottomID)
          ForEach(
            self.messages,
            id: \.message.id
          ) { (item: ChatMessageSectionItem) in
            let isFirstInGroup = self.isFirstInGroup(at: item.index)
            ChatRoomMessageContainerView(
              message: item.message,
              isFirstInGroup: isFirstInGroup
            )
            .onAppear {
              self.appearIndex = item.index
            }
            .id(item.message.id)
            .modifier(
              ChatRoomDirectionalModifier(
                isSender: item.message.isSender,
                isFirstInGroup: isFirstInGroup
              )
            )
            if self.shouldShowDateHeader(at: item.index) {
              ChatRoomDateHeaderView(date: item.message.date)
            }
          }
        }
        .rotationEffect(Angle(degrees: 180))
        .listRowBackground(Color.white)
        .listRowSeparator(.hidden)
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
      }
      .scrollIndicators(.hidden)
      .listStyle(.plain)
      .environment(\.defaultMinListRowHeight, 0)
      .onChange(of: self.scrollToBottom) { _, newValue in
        if newValue {
          proxy.scrollTo(Constant.bottomID)
          self.scrollToBottom = false
        }
      }
      .rotationEffect(Angle(degrees: 180))
      .background(Color.white)
    }
    .background(Color.white)
  }
  
  // MARK: - Method
  
  private func isFirstInGroup(at index: Int) -> Bool {
    let prevIndex = index + 1
    guard self.messages.indices ~= prevIndex else { return true }
    let currMessage: ChatMessage = self.messages[index].message
    let prevMessage: ChatMessage = self.messages[prevIndex].message
    let currUserIdx = currMessage.user.userIdx
    let prevUserIdx =  prevMessage.user.userIdx
    return currUserIdx != prevUserIdx
  }
  
  private func shouldShowDateHeader(at index: Int) -> Bool {
    let prevIndex = index + 1
    guard index < (self.messages.count - 1) else { return true }
    guard self.messages.indices ~= prevIndex else { return false }
    let currMessage: ChatMessage = self.messages[index].message
    let prevMessage: ChatMessage = self.messages[prevIndex].message
    let currDate = currMessage.date.timeIntervalSinceReferenceDate
    let prevDate = prevMessage.date.timeIntervalSinceReferenceDate
    return (currDate - prevDate) > 3600
  }
}


#Preview {
  ChatRoomMessageListView(
    messages: .constant([
      .init(
        message: .init(
          messageIdx: "",
          user: .init(userIdx: "11", nickname: "하이룽", thumbnail: nil),
          messageKind: .text("하이룽"),
          isSender: false,
          date: .now
        ),
        index: 0
      )
    ]),
    scrollToBottom: .constant(true),
    appearIndex: .constant(0)
  )
}
