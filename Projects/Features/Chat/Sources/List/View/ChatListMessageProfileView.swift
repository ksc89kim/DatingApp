//
//  ChatListMessageProfileView.swift
//  Chat
//
//  Created by kim sunchul on 11/26/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI
import Kingfisher

struct ChatListMessageProfileView: View {

  // MARK: - Define

  private typealias Assets = ChatAsset.Assets

  // MARK: - Property

  let profile: ChatListProfile

  var body: some View {
    KFAnimatedImage(profile.thumbnail)
      .cancelOnDisappear(true)
      .placeholder {
        Circle()
          .foregroundColor(
            Assets.chatChosenPlaceholder.swiftUIColor
          )
          .overlay {
            Image(systemName: "person.fill")
              .resizable()
              .frame(width: 30, height: 30)
              .foregroundColor(
                Assets.chatChosenPlaceholderPerson.swiftUIColor
              )
          }
      }
      .fade(duration: 1)
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
  }
}

#Preview {
  ChatListMessageProfileView(
    profile: .init(thumbnail: nil, badge: false)
  )
}
