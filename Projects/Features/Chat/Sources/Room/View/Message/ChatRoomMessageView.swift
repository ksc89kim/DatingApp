//
//  ChatRoomMessageView.swift
//  Chat
//
//  Created by kim sunchul on 1/4/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import SwiftUI
import Util

struct ChatRoomMessageView: View {

  // MARK: - Property

  let message: String

  let isSender: Bool

  let isFirstInGroup: Bool

  private var backgroundPadding: EdgeInsets {
    return .init(top: 12, leading: 15, bottom: 12, trailing: 15)
  }

  private var bigCornerRadius: UIRectCorner {
    if self.isSender {
      if self.isFirstInGroup {
        return [.topLeft, .topRight, .bottomLeft]
      } else {
        return [.topLeft, .bottomLeft]
      }
    } else {
      if self.isFirstInGroup {
        return [.topLeft, .topRight, .bottomRight]
      } else {
        return [.topRight, .bottomRight]
      }
    }
  }

  private var smallCorenrRadius: UIRectCorner {
    if self.isSender {
      if self.isFirstInGroup {
        return [.bottomRight]
      } else {
        return [.topRight, .bottomRight]
      }
    } else {
      if self.isFirstInGroup {
        return [.bottomLeft]
      } else {
        return [.topLeft, .bottomLeft]
      }
    }
  }

  var body: some View {
    if self.isSender {
      self.senderMessage
    } else {
      self.otherMessage
    }
  }

  @ViewBuilder
  private var senderMessage: some View {
    Text(self.message)
      .accessibilityLabel("내가 보낸 메시지")
      .accessibilityRemoveTraits(.isStaticText)
      .accessibilityValue(self.message)
      .padding(self.backgroundPadding)
      .systemScaledFont(style: .text)
      .foregroundStyle(UtilAsset.MainColor.text.swiftUIColor)
      .background(UtilAsset.MainColor.background.swiftUIColor)
      .cornerRadius(18, corners: self.bigCornerRadius)
      .cornerRadius(4, corners: self.smallCorenrRadius)
  }

  @ViewBuilder
  private var otherMessage: some View {
    Text(self.message)
      .accessibilityLabel("상대방이 보낸 메시지")
      .accessibilityRemoveTraits(.isStaticText)
      .accessibilityValue(self.message)
      .padding(self.backgroundPadding)
      .systemScaledFont(style: .text)
      .foregroundColor(Color.black)
      .background(ChatAsset.Assets.chatMessageOtherBackground.swiftUIColor)
      .cornerRadius(18, corners: self.bigCornerRadius)
      .cornerRadius(4, corners: self.smallCorenrRadius)
  }
}


#Preview {
  ChatRoomMessageView(
    message: "안녕하세요? 오랜만이에요.",
    isSender: false, 
    isFirstInGroup: true
  )
}
