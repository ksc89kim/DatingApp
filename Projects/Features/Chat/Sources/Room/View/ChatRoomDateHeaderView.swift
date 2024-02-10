//
//  ChatRoomDateHeaderView.swift
//  Chat
//
//  Created by kim sunchul on 1/5/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import SwiftUI

struct ChatRoomDateHeaderView: View {

  // MARK: - Property

  let date: Date

  var body: some View {
    Text(ChatDate.string(from: self.date))
      .frame(maxWidth: .infinity)
      .foregroundStyle(ChatAsset.Assets.chatMessageDateHeader.swiftUIColor)
      .systemScaledFont(font: .medium, size: 14)
      .padding()
      .accessibilityRemoveTraits(.isStaticText)
  }
}


#Preview {
  ChatRoomDateHeaderView(date: .now)
}
