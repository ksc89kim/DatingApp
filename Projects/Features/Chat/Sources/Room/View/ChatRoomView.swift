//
//  ChatRoomView.swift
//  Chat
//
//  Created by kim sunchul on 12/22/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI
import DI
import ChatInterface
import Util

struct ChatRoomView: View {
  
  // MARK: - Property
  
  let roomIdx: String
  
  @ObservedObject
  private var viewModel: ChatRoomViewModel = DIContainer.resolve(
    for: ChatRoomViewModelKey.self
  )
  
  @State
  private var appearListIndex: Int =  0
  
  var body: some View {
    VStack {
      ChatRoomMessageListView(
        messages: self.$viewModel.state.items,
        scrollToBottom: self.$viewModel.state.scrollToBottm,
        appearIndex: .init(
          get: {
            return self.appearListIndex
          },
          set: { newValue in
            self.viewModel.trigger(.loadMoreMessages(index: newValue))
            self.appearListIndex = newValue
          }
        )
      )
      ChatRoomInputView(
        messageText: self.$viewModel.state.newMessage,
        onSend: {
          self.viewModel.trigger(.sendMessage)
        }
      )
    }
    .background(Color.white)
    .onAppear {
      self.viewModel.trigger(.loadRoomInfo(roomIdx: self.roomIdx))
    }
    .alert(isPresented:
        .constant(self.viewModel.state.isPresentAlert)
    ) {
      self.buildAlert(self.viewModel.state.alert)
    }
  }
}


extension ChatRoomView: AlertBuildable { }


#Preview {
  ChatDIRegister.register()
  return ChatRoomView(roomIdx: "123")
}
