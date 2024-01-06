//
//  ChatRoomView.swift
//  Chat
//
//  Created by kim sunchul on 12/22/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI

struct ChatRoomView: View {

  // MARK: - Property

  var roomIdx: String

  @State
  var newMessage: String = ""

  var body: some View {
    VStack {
      ChatRoomMessageListView()
      ChatRoomInputView(
        messageText: self.$newMessage,
        onSend: {}
      )
    }
    .background(Color.white)
  }
}


#Preview {
  ChatRoomView(roomIdx: "123")
}
