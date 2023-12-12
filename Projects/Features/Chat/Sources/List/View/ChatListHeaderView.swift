//
//  ChatListHeaderView.swift
//  Chat
//
//  Created by kim sunchul on 11/26/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI
import Util

struct ChatListHeaderView: View {

  // MARK: - Property

  let title: String

  var body: some View {
    Text(self.title)
      .systemScaledFont(font: .semibold, size: 16)
      .foregroundStyle(.black)
      .padding(.leading, 15)
      .padding(.top, 7)
      .padding(.bottom, 14)
      .frame(maxWidth: .infinity, alignment: .leading)
  }
}


#Preview {
  ChatListHeaderView(title: "테스트")
}
