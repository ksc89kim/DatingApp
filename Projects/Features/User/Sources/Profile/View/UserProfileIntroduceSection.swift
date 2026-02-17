//
//  UserProfileIntroduceSection.swift
//  User
//
//  Created by kim sunchul on 2/15/26.
//

import SwiftUI
import Util

struct UserProfileIntroduceSection: View {

  // MARK: - Define

  private typealias MainColor = UtilAsset.MainColor

  // MARK: - Define

  private enum Metric {
    static let horizontalPadding: CGFloat = 18
    static let sectionSpacing: CGFloat = 16
    static let textTopSpacing: CGFloat = 10
  }

  // MARK: - Property

  let introduce: String

  var body: some View {
    if !self.introduce.isEmpty {
      VStack(alignment: .leading, spacing: 0) {
        Divider()
          .padding(.vertical, Metric.sectionSpacing)
        HStack(spacing: 6) {
          Image(systemName: "text.quote")
            .font(.system(size: 15))
            .foregroundStyle(
              MainColor.accent.swiftUIColor
            )
          Text("소개")
            .systemScaledFont(
              font: .semibold,
              size: 17
            )
            .foregroundStyle(Color(.label))
        }
          .padding(
            .bottom,
            Metric.textTopSpacing
          )
        Text(self.introduce)
          .systemScaledFont(
            font: .regular,
            size: 15
          )
          .foregroundStyle(Color(.secondaryLabel))
          .lineSpacing(4)
          .fixedSize(horizontal: false, vertical: true)
      }
      .padding(
        .horizontal,
        Metric.horizontalPadding
      )
    }
  }
}
