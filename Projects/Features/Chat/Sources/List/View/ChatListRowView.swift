//
//  ChatListRowView.swift
//  Chat
//
//  Created by kim sunchul on 11/26/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI
import Util

struct ChatListRowView: View {
  
  // MARK: - Define
  
  private typealias Assets = ChatAsset.Assets
  
  // MARK: - Property
  
  var body: some View {
    HStack {
      ChatListProfileView()
        .padding(.leading, 15)
        .padding(.trailing, 13)
      VStack(alignment: .leading, spacing: 8) {
        Text("Kim")
          .systemScaledFont(font: .bold, size: 16)
        Text("Hi~")
          .systemScaledFont(font: .medium, size: 14)
          .foregroundStyle(
            Assets.chatListRowContentRead.swiftUIColor
          )
      }
      Spacer()
    }
    .padding(.vertical, 10)
  }
}


#Preview {
  ChatListRowView()
}
