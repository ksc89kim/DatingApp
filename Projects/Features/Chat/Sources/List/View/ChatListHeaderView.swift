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

  var body: some View {
    VStack {
      Text("22개의 대화방")
        .systemScaledFont(font: .semibold, size: 16)
        .foregroundStyle(.black)
    }
    .padding(.leading, 15)
    .padding(.top, 7)
    .padding(.bottom, 20)
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}


#Preview {
  ChatListHeaderView()
}
