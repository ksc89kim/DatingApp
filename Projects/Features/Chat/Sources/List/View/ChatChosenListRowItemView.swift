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

  var onTap: (() -> Void)?

  var body: some View {
    VStack(spacing: 12) {
      ChatChosenProfileView(profile: self.item.profile)
      Text(self.item.nickname)
        .foregroundStyle(.black)
        .systemScaledFont(font: .bold, size: 12)
        .accessibilityLabel("유저 닉네임")
        .accessibilityValue(self.item.nickname)
    }
    .accessibilityElement(children: .combine)
    .padding(.leading, 8)
    .contentShape(Rectangle())
    .onTapGesture {
      self.onTap?()
    }
  }
}


#Preview {
  return ChatChosenListRowItemView(item: .dummy())
}
