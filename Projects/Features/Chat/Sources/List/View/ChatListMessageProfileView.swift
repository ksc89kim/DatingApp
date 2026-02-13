//
//  ChatListMessageProfileView.swift
//  Chat
//
//  Created by kim sunchul on 11/26/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI
import Util

struct ChatListMessageProfileView: View {

  // MARK: - Define

  private typealias Assets = ChatAsset.Assets

  // MARK: - Property

  let profile: ChatListProfile

  var body: some View {
    LoadImage(url: profile.thumbnail,
              placeHolderView: ProfilePlaceHolder())
      .frame(width: 65, height: 65)
      .cornerRadius(32)
      .overlay {
        Circle()
          .strokeBorder(Color.white, lineWidth: 3)
          .background(
            Circle()
              .foregroundColor(Color.red)
          )
          .offset(x: 23, y: -23)
          .frame(width: 17)
          .opacity(self.profile.badge ? 1.0 : 0.0)
      }
      .accessibilityElement(children: .ignore)
  }
}

#Preview {
  ChatListMessageProfileView(
    profile: .init(thumbnail: nil, badge: false)
  )
}
