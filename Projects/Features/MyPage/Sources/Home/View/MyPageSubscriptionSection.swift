//
//  MyPageSubscriptionSection.swift
//  MyPage
//
//  Created by kim sunchul on 2/21/26.
//

import SwiftUI
import Util

struct MyPageSubscriptionSection: View {

  // MARK: - Define

  private typealias MyPageColor = MyPageAsset.MyPageColor

  private enum Metric {
    static let cardPadding: CGFloat = 16
    static let cardCornerRadius: CGFloat = 16
    static let horizontalMargin: CGFloat = 16
    static let upgradeButtonHeight: CGFloat = 48
  }

  // MARK: - Property

  let onTapUpgrade: () -> Void

  // MARK: - State

  @State private var isVisible: Bool = false

  // MARK: - Body

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      self.headerRow
      self.featureList
      self.upgradeButton
    }
    .padding(Metric.cardPadding)
    .background(self.cardGradient)
    .clipShape(RoundedRectangle(cornerRadius: Metric.cardCornerRadius))
    .padding(.horizontal, Metric.horizontalMargin)
    .opacity(self.isVisible ? 1 : 0)
    .offset(y: self.isVisible ? 0 : 20)
    .onAppear {
      withAnimation(.easeOut(duration: 0.4).delay(0.3)) {
        self.isVisible = true
      }
    }
  }

  // MARK: - Private

  private var cardGradient: some ShapeStyle {
    LinearGradient(
      colors: [
        MyPageColor.subscriptionCardBgStart.swiftUIColor,
        MyPageColor.subscriptionCardBgEnd.swiftUIColor
      ],
      startPoint: .topLeading,
      endPoint: .bottomTrailing
    )
  }

  private var goldTextColor: Color {
    MyPageColor.subscriptionGoldText.swiftUIColor
  }

  private var subtitleColor: Color {
    MyPageColor.subscriptionSubtitle.swiftUIColor
  }

  private var headerRow: some View {
    HStack {
      VStack(alignment: .leading, spacing: 4) {
        HStack(spacing: 8) {
          Text("DatingApp")
            .systemScaledFont(font: .bold, size: 18)
            .foregroundStyle(self.goldTextColor)
          Text("GOLD")
            .systemScaledFont(font: .bold, size: 12)
            .foregroundStyle(self.goldTextColor)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(MyPageColor.subscriptionBadgeBg.swiftUIColor.opacity(0.3))
            .clipShape(Capsule())
        }
        Text("더 많은 기능을 경험해보세요")
          .systemScaledFont(font: .regular, size: 14)
          .foregroundStyle(self.subtitleColor)
      }
      Spacer()
    }
  }

  private var featureList: some View {
    VStack(alignment: .leading, spacing: 8) {
      self.featureRow(icon: "heart.fill", text: "무제한 좋아요")
      self.featureRow(icon: "eye.fill", text: "LIKE 확인")
      self.featureRow(icon: "star.fill", text: "슈퍼라이크")
      self.featureRow(icon: "bolt.fill", text: "부스트")
    }
  }

  private var upgradeButton: some View {
    Button(action: self.onTapUpgrade) {
      Text("업그레이드")
        .systemScaledFont(font: .semibold, size: 16)
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .frame(height: Metric.upgradeButtonHeight)
        .background(
          LinearGradient(
            colors: [
              MyPageColor.subscriptionUpgradeStart.swiftUIColor,
              MyPageColor.subscriptionUpgradeEnd.swiftUIColor
            ],
            startPoint: .leading,
            endPoint: .trailing
          )
        )
        .clipShape(Capsule())
    }
    .buttonStyle(PressedButtonStyle())
  }

  private func featureRow(icon: String, text: String) -> some View {
    HStack(spacing: 8) {
      Image(systemName: icon)
        .font(.system(size: 14))
        .foregroundStyle(self.goldTextColor)
        .frame(width: 20)
      Text(text)
        .systemScaledFont(font: .regular, size: 14)
        .foregroundStyle(self.subtitleColor)
    }
  }
}
