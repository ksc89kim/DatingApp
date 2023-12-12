//
//  ChatListEmptyView.swift
//  Chat
//
//  Created by kim sunchul on 12/12/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI
import Util

struct ChatListEmptyView: View {

  // MARK: - Define

  private typealias MainColor = UtilAsset.MainColor

  // MARK: - Property

  var body: some View {
    VStack {
      Image(systemName: "ellipsis.message.fill")
        .resizable()
        .frame(width: 80, height: 80)
        .foregroundStyle(MainColor.background.swiftUIColor)
      Spacer()
        .frame(height: 24)
      Text("대화하고 있는 사람이 없어요!")
        .systemScaledFont(style: .boldTitle)
      Spacer()
        .frame(height: 8)
      Text("매칭을 통해서,\n더 많은 사람들과 대화하고 즐겁게 놀아요!")
        .multilineTextAlignment(.center)
        .foregroundStyle(MainColor.placeHolder.swiftUIColor)
    }
  }
}


#Preview {
  ChatListEmptyView()
}
