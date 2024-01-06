//
//  ChatRoomInputView.swift
//  Chat
//
//  Created by kim sunchul on 1/5/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import SwiftUI
import Util

struct ChatRoomInputView: View {
  
  // MARK: - Property
  
  @Binding
  var messageText: String
  
  var onSend: () -> Void
  
  var body: some View {
    HStack(spacing: 10) {
      self.textEditor
      self.sendButton
    }
    .padding(.horizontal, 12)
    .padding(.vertical, 8)
  }
  
  @ViewBuilder
  private var textEditor: some View {
    TextEditor(text: self.$messageText)
      .scrollContentBackground(.hidden)
      .background(Color.white)
      .foregroundStyle(Color.black)
      .tint(Color.black)
      .font(.system(size: 14))
      .frame(minHeight: CGFloat(35), maxHeight: 100)
      .padding(.horizontal, 8)
      .padding(.vertical, 4)
      .overlay(
        RoundedRectangle(cornerRadius: 20)
          .stroke(
            ChatAsset.Assets.chatMessageInputBorder.swiftUIColor,
            lineWidth: 1
          )
      )
      .fixedSize(horizontal: false, vertical: true)
  }
  
  @ViewBuilder
  private var sendButton: some View {
    Button(action: self.onSend) {
      Circle()
        .frame(width: 35)
        .overlay {
          Image(systemName: "paperplane.fill")
            .resizable()
            .frame(width: 12, height: 12)
            .tint(Color.white)
        }
        .tint(UtilAsset.MainColor.background.swiftUIColor)
    }
  }
}


#Preview {
  ChatRoomInputView(
    messageText: .constant(""),
    onSend: {}
  )
}
