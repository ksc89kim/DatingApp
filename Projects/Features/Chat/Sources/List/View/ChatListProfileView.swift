//
//  ChatListProfileView.swift
//  Chat
//
//  Created by kim sunchul on 11/26/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI

struct ChatListProfileView: View {
  
  // MARK: - Define

  private typealias Assets = ChatAsset.Assets

  // MARK: - Property

  var body: some View {
    Circle()
      .frame(width: 65)
      .foregroundColor(
        Assets.chatChosenPlaceholder.swiftUIColor
      )
      .overlay {
        ZStack {
          Image(systemName: "person.fill")
            .resizable()
            .frame(width: 30, height: 30)
            .foregroundColor(
              Assets.chatChosenPlaceholderPerson.swiftUIColor
            )
          ChatAsset.Assets.testProfile.swiftUIImage
            .resizable()
            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            .clipShape(Circle())
          Circle()
            .strokeBorder(Color.white, lineWidth: 3)
            .background(
              Circle()
                .foregroundColor(Color.red)
            )
            .offset(x: 23, y: -23)
            .frame(width: 17)
        }
      }
  }
}

#Preview {
  ChatListProfileView()
}
