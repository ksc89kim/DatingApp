//
//  ChatRoomProfileView.swift
//  Chat
//
//  Created by kim sunchul on 2/1/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import SwiftUI
import ChatInterface
import Kingfisher
import Util

struct ChatRoomProfileView: View {
  
  // MARK: - Define

  private typealias Assets = ChatAsset.Assets
  
  // MARK: - Property
  
  var partner: ChatUser?
  
  var body: some View {
    HStack(spacing: 8) {
      KFAnimatedImage(self.partner?.thumbnail)
        .cancelOnDisappear(true)
        .placeholder {
          ProfilePlaceHolder()
        }
        .fade(duration: 1)
        .frame(width: 35, height: 35)
        .cornerRadius(17)
      Text(self.partner?.nickname ?? "")
        .systemScaledFont(font: .bold, size: 16)
        
    }
    .accessibilityElement(children: .combine)
    .accessibilityLabel("사용자 프로필")
    .accessibilityValue(self.partner?.nickname ?? "")
  }
}


#Preview {
  ChatRoomProfileView(
    partner: .init(
      userIdx: "",
      nickname: "테스트",
      thumbnail: nil
    )
  )
}
