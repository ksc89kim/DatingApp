//
//  ChatListMessageRowView.swift
//  Chat
//
//  Created by kim sunchul on 11/26/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI
import Util

struct ChatListMessageRowView: View {

  // MARK: - Define

  private typealias Assets = ChatAsset.Assets

  // MARK: - Property

  let item: ChatListMessageSectionItem

  var body: some View {
    HStack {
      ChatListMessageProfileView(profile: self.item.profile)
        .padding(.leading, 15)
        .padding(.trailing, 13)
      VStack(alignment: .leading, spacing: 8) {
        Text(self.item.nickname)
          .foregroundStyle(.black)
          .systemScaledFont(font: .bold, size: 16)
          .accessibilityLabel("유저 닉네임")
          .accessibilityValue(self.item.nickname)
        Text(self.item.message)
          .foregroundStyle(.black)
          .systemScaledFont(font: .regular, size: 14)
          .accessibilityLabel("메시지")
          .accessibilityValue(self.item.message)
          .foregroundStyle(
            self.item.isRead ?
            Assets.chatListRowContentRead.swiftUIColor :
              Color.black
          )
      }
      Spacer()
    }
    .contentShape(Rectangle())
    .accessibilityElement(children: .combine)
    .padding(.vertical, 10)
  }
}


#Preview {
  ChatListMessageRowView(item: .dummy())
}
