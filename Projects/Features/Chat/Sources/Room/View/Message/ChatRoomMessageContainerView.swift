//
//  ChatRoomMessageContainerView.swift
//  Chat
//
//  Created by kim sunchul on 1/4/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import SwiftUI
import ChatInterface

struct ChatRoomMessageContainerView: View {

  // MARK: - Property

  let message: ChatMessage

  let isFirstInGroup: Bool

  var body: some View {
    switch self.message.messageKind {
    case .text(let text):
      ChatRoomMessageView(
        message: text,
        isSender: self.message.isSender,
        isFirstInGroup: self.isFirstInGroup
      )
    }
  }
}


#Preview {
  ChatRoomMessageContainerView(
    message: .init(
      user: .init(userIdx: "", nickname: "", thumbnail: nil),
      messageKind: .text("test"),
      isSender: false,
      date: .init()
    ), 
    isFirstInGroup: true
  )
}
