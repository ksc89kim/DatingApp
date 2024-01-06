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

  // MARK: - Property

  var messages: [ChatMessage] = {
    let date: Date = .now
    return [
      .init(
        user: .init(userIdx: "33", nickname: "", thumbnail: nil),
        messageKind: .text("안녕"),
        isSender: false,
        date: date
      ),
      .init(
        user: .init(userIdx: "11", nickname: "", thumbnail: nil),
        messageKind: .text("안녕?"),
        isSender: true,
        date: date
      ),
      .init(
        user: .init(userIdx: "11", nickname: "", thumbnail: nil),
        messageKind: .text("잘지내?"),
        isSender: true,
        date: date
      ),
      .init(
        user: .init(userIdx: "33", nickname: "", thumbnail: nil),
        messageKind: .text("그럭저럭"),
        isSender: false,
        date: date.addingTimeInterval(3700)
      )
    ]
  }()
    

  var body: some View {
    ScrollView {
      ScrollViewReader { _ in
        LazyVStack(spacing: 0) {
          ForEach(
            self.messages.enumerated().map { $0 },
            id: \.1.id
          ) { offset, message in
            let isFirstInGroup = self.isFirstInGroup(at: offset)
            if self.shouldShowDateHeader(at: offset) {
              ChatRoomDateHeaderView(date: message.date)
            }
            ChatRoomMessageContainerView(
              message: message,
              isFirstInGroup: isFirstInGroup
            )
            .id(message.id)
            .modifier(
              ChatRoomDirectionalModifier(
                isSender: message.isSender,
                isFirstInGroup: isFirstInGroup
              )
            )
          }
        }
      }
    }
  }

  // MARK: - Method

  private func isFirstInGroup(at index: Int) -> Bool {
    guard self.messages.indices ~= (index-1) else { return true }
    let currUserID = self.messages[index].user.userIdx
    let prevUserID =  self.messages[index - 1].user.userIdx
    return currUserID != prevUserID
  }

  private func shouldShowDateHeader(at index: Int) -> Bool {
    guard index != 0 else { return true }
    guard self.messages.indices ~= (index-1) else { return false }
    let currDate = self.messages[index].date.timeIntervalSinceReferenceDate
    let prevDate =  self.messages[index - 1].date.timeIntervalSinceReferenceDate
    return (currDate - prevDate) > 3600
  }
}


#Preview {
  ChatRoomMessageListView()
}
