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
      ChatListProfileView(profile: self.item.toProfile())
        .padding(.leading, 15)
        .padding(.trailing, 13)
      VStack(alignment: .leading, spacing: 8) {
        Text(item.nickname)
          .systemScaledFont(font: .bold, size: 16)
        Text(item.message)
          .systemScaledFont(font: .regular, size: 14)
          .foregroundStyle(
            self.item.isRead ?
            Assets.chatListRowContentRead.swiftUIColor :
              Color.black
          )
      }
      Spacer()
    }
    .padding(.vertical, 10)
  }
}


#Preview {
  ChatListMessageRowView(item: .dummy())
}
