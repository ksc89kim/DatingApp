//
//  UserProfileErrorView.swift
//  User
//
//  Created by kim sunchul on 2/16/26.
//

import SwiftUI
import Util

struct UserProfileErrorView: View {

  // MARK: - Define

  private typealias MainColor = UtilAsset.MainColor

  // MARK: - Property

  let message: String

  let onRetry: () -> Void

  var body: some View {
    VStack(spacing: 16) {
      Image(systemName: "wifi.slash")
        .font(.system(size: 40))
        .foregroundStyle(Color(.secondaryLabel))
      Text("프로필을 불러올 수 없습니다")
        .systemScaledFont(font: .semibold, size: 17)
        .foregroundStyle(Color(.label))
      Text(self.message)
        .systemScaledFont(font: .regular, size: 14)
        .foregroundStyle(Color(.secondaryLabel))
        .multilineTextAlignment(.center)
      Button {
        self.onRetry()
      } label: {
        Text("다시 시도")
          .systemScaledFont(font: .bold, size: 14)
          .foregroundStyle(.white)
          .padding(.horizontal, 24)
          .padding(.vertical, 12)
          .background(
            MainColor.background.swiftUIColor
          )
          .clipShape(
            RoundedRectangle(cornerRadius: 12)
          )
      }
      .buttonStyle(PressedButtonStyle())
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(.systemBackground))
  }
}
