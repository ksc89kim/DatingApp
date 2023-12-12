//
//  ChatChosenListRowItem.swift
//  Chat
//
//  Created by kim sunchul on 11/24/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI
import Util
import ChatInterface

struct ChatChosenListRowItemView: View {

  // MARK: - Property

  let item: ChatChosenSectionItem

  var body: some View {
    VStack(spacing: 8) {
      ChatListProfileView(profile: self.item.toProfile())
      Text(self.item.nickname)
        .systemScaledFont(font: .semibold, size: 12)
    }
    .padding(.leading, 15)
  }
}


#Preview {
  return ChatChosenListRowItemView(item: .dummy())
}
