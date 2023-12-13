//
//  ChatChosenProfileView.swift
//  Chat
//
//  Created by kim sunchul on 12/12/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI
import Kingfisher

struct ChatChosenProfileView: View {

  // MARK: - Define

  private typealias Assets = ChatAsset.Assets

  // MARK: - Property

  let profile: ChatListProfile
  // MARK: - Property

  var body: some View {
    ZStack(alignment: .trailing) {
      KFAnimatedImage(profile.thumbnail)
        .cancelOnDisappear(true)
        .placeholder {
          RoundedRectangle(cornerRadius: 12)
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
        .aspectRatio(contentMode: .fill)
        .frame(width: 95, height: 125)
        .cornerRadius(12)
      Circle()
        .strokeBorder(Color.white, lineWidth: 3)
        .background(
          Circle()
            .foregroundColor(Color.red)
        )
        .offset(x: 8)
        .frame(width: 17)
        .opacity(self.profile.badge ? 1.0 : 0.0)
    }
    .accessibilityLabel("유저 이미지")
    .accessibilityAddTraits(.isImage)
  }
}


#Preview {
  ChatChosenProfileView(
    profile: .init(
      thumbnail: nil,
      badge: true
    )
  )
}
