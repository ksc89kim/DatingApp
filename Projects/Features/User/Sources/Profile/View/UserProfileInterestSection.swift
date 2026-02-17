//
//  UserProfileInterestSection.swift
//  User
//
//  Created by kim sunchul on 2/15/26.
//

import SwiftUI
import Util

struct UserProfileInterestSection: View {

  // MARK: - Define

  private typealias MainColor = UtilAsset.MainColor

  private enum Metric {
    static let horizontalPadding: CGFloat = 18
    static let sectionSpacing: CGFloat = 16
    static let chipTopSpacing: CGFloat = 12
  }

  // MARK: - Property

  let chips: [Chip]

  let selections: Set<Chip>

  var body: some View {
    if !self.chips.isEmpty {
      VStack(alignment: .leading, spacing: 0) {
        Divider()
          .padding(.vertical, Metric.sectionSpacing)
        HStack(spacing: 6) {
          Image(systemName: "gamecontroller.fill")
            .font(.system(size: 15))
            .foregroundStyle(
              MainColor.accent.swiftUIColor
            )
          Text("관심사")
            .systemScaledFont(
              font: .semibold,
              size: 17
            )
            .foregroundStyle(Color(.label))
        }
          .padding(
            .bottom,
            Metric.chipTopSpacing
          )
        ChipContainerView(
          items: self.chips,
          selections: .constant(self.selections),
          appearance: self.chipAppearance
        )
        .allowsHitTesting(false)
      }
      .padding(
        .horizontal,
        Metric.horizontalPadding
      )
    }
  }
}


// MARK: - Private

private extension UserProfileInterestSection {

  var chipAppearance: ChipAppearance {
    ChipAppearance(
      selectedBackgroundColor:
        MainColor.accent.swiftUIColor,
      unselectedBackgroundColor:
        Color.gray.opacity(0.2),
      selectedForegroundColor: .white,
      unselectedForegroundColor: Color(.label)
    )
  }
}
