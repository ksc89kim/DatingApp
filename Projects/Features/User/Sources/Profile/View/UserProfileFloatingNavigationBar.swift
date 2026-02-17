//
//  UserProfileFloatingNavigationBar.swift
//  User
//
//  Created by kim sunchul on 2/15/26.
//

import SwiftUI
import UserInterface

struct UserProfileFloatingNavigationBar: View {

  // MARK: - Property

  let entryType: UserProfileEntryType

  let onBack: () -> Void

  let onMore: () -> Void

  var body: some View {
    VStack {
      HStack {
        Button {
          self.onBack()
        } label: {
          Image(systemName: "chevron.backward")
            .font(.system(size: 16, weight: .bold))
            .foregroundStyle(.white)
            .frame(width: 44, height: 44)
        }
        .shadow(color: .black.opacity(0.3), radius: 2)
        .accessibilityLabel("뒤로 가기")
        Spacer()
        if self.entryType == .matchRecommend
          || self.entryType == .chatList {
          Button {
            self.onMore()
          } label: {
            Image(systemName: "ellipsis")
              .font(.system(size: 20, weight: .bold))
              .foregroundStyle(.white)
              .shadow(
                color: .black.opacity(0.3),
                radius: 2
              )
              .frame(width: 44, height: 44)
          }
        }
      }
      .padding(.horizontal, 4)
      Spacer()
    }
    .safeAreaPadding(.top)
    .padding(.top, 4)
  }
}
