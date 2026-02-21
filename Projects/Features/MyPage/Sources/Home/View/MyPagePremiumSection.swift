//
//  MyPagePremiumSection.swift
//  MyPage
//
//  Created by kim sunchul on 2/21/26.
//

import SwiftUI
import Util

struct MyPagePremiumSection: View {

  // MARK: - Define

  private typealias MainColor = UtilAsset.MainColor

  private enum Metric {
    static let cellHeight: CGFloat = 120
    static let cellCornerRadius: CGFloat = 12
    static let gridSpacing: CGFloat = 12
    static let horizontalMargin: CGFloat = 16
  }

  // MARK: - Property

  let superLikeCount: Int

  let boostCount: Int

  let onTapSuperLike: () -> Void

  let onTapBoost: () -> Void

  let onTapSubscription: () -> Void

  // MARK: - State

  @State private var isVisible: Bool = false

  // MARK: - Body

  var body: some View {
    LazyVGrid(
      columns: [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
      ],
      spacing: Metric.gridSpacing
    ) {
      self.premiumCell(
        icon: "star.fill",
        iconColor: MyPageAsset.MyPageColor.premiumBlue.swiftUIColor,
        title: "\(self.superLikeCount)개",
        subtitle: "더 구매",
        action: self.onTapSuperLike
      )
      self.premiumCell(
        icon: "bolt.fill",
        iconColor: MyPageAsset.MyPageColor.premiumPurple.swiftUIColor,
        title: "\(self.boostCount)개",
        subtitle: "더 구매",
        action: self.onTapBoost
      )
      self.premiumCell(
        icon: "flame.fill",
        iconColor: MainColor.accent.swiftUIColor,
        title: nil,
        subtitle: "구독하기",
        action: self.onTapSubscription
      )
    }
    .padding(.horizontal, Metric.horizontalMargin)
    .opacity(self.isVisible ? 1 : 0)
    .offset(y: self.isVisible ? 0 : 20)
    .onAppear {
      withAnimation(.easeOut(duration: 0.4).delay(0.2)) {
        self.isVisible = true
      }
    }
  }

  // MARK: - Private

  private func premiumCell(
    icon: String,
    iconColor: Color,
    title: String?,
    subtitle: String,
    action: @escaping () -> Void
  ) -> some View {
    Button(action: action) {
      VStack(spacing: 8) {
        Image(systemName: icon)
          .font(.system(size: 28))
          .foregroundStyle(iconColor)

        if let title = title {
          Text(title)
            .systemScaledFont(font: .semibold, size: 15)
            .foregroundStyle(Color(.label))
        }

        Text(subtitle)
          .systemScaledFont(font: .regular, size: 13)
          .foregroundStyle(Color(.secondaryLabel))
      }
      .frame(maxWidth: .infinity)
      .frame(height: Metric.cellHeight)
      .background(Color(.tertiarySystemBackground))
      .clipShape(RoundedRectangle(cornerRadius: Metric.cellCornerRadius))
    }
    .buttonStyle(PressedButtonStyle())
  }
}
