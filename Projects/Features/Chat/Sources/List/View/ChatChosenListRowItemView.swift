//
//  ChatChosenListRowItem.swift
//  Chat
//
//  Created by kim sunchul on 11/24/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI
import Util

struct ChatChosenListRowItemView: View {

  // MARK: - Property

  var body: some View {
    VStack(spacing: 8) {
      ChatListProfileView()
      Text("Kim")
        .systemScaledFont(font: .semibold, size: 12)
    }
    .padding(.leading, 15)
  }
}


#Preview {
  ChatChosenListRowItemView()
}
