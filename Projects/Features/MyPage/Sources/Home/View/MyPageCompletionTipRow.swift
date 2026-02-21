//
//  MyPageCompletionTipRow.swift
//  MyPage
//
//  Created by kim sunchul on 2/21/26.
//

import SwiftUI
import Util

struct MyPageCompletionTipRow: View {

  // MARK: - Define

  private typealias MainColor = UtilAsset.MainColor

  private enum Metric {
    static let iconBoxSize: CGFloat = 40
    static let iconBoxCornerRadius: CGFloat = 10
    static let checkCircleSize: CGFloat = 24
    static let rowPadding: CGFloat = 16
    static let rowCornerRadius: CGFloat = 12
  }

  // MARK: - Property

  let tip: ProfileCompletionTip

  let onTap: () -> Void

  // MARK: - Body

  var body: some View {
    Button(action: self.onTap) {
      HStack(spacing: 12) {
        self.iconBox
        self.textContent
        Spacer()
        self.completionIndicator
      }
      .padding(Metric.rowPadding)
      .background(Color(.systemBackground))
      .clipShape(RoundedRectangle(cornerRadius: Metric.rowCornerRadius))
    }
    .buttonStyle(PressedButtonStyle())
  }

  // MARK: - Private

  private var iconBox: some View {
    ZStack(alignment: .bottomTrailing) {
      Image(systemName: self.tip.sfSymbol)
        .font(.system(size: 18))
        .foregroundStyle(MainColor.accent.swiftUIColor)
        .frame(
          width: Metric.iconBoxSize,
          height: Metric.iconBoxSize
        )
        .background(MainColor.accent.swiftUIColor.opacity(0.12))
        .clipShape(
          RoundedRectangle(cornerRadius: Metric.iconBoxCornerRadius)
        )

      Text("+\(self.tip.percentageBoost)%")
        .systemScaledFont(font: .bold, size: 9)
        .foregroundStyle(.white)
        .padding(.horizontal, 4)
        .padding(.vertical, 2)
        .background(MainColor.accent.swiftUIColor)
        .clipShape(Capsule())
        .offset(x: 6, y: 4)
    }
    .padding(.trailing, 6)
    .padding(.bottom, 4)
  }

  private var textContent: some View {
    VStack(alignment: .leading, spacing: 2) {
      Text(self.tip.title)
        .systemScaledFont(font: .semibold, size: 15)
        .foregroundStyle(Color(.label))
      Text(self.tip.description)
        .systemScaledFont(font: .regular, size: 13)
        .foregroundStyle(Color(.secondaryLabel))
    }
  }

  private var completionIndicator: some View {
    ZStack {
      if self.tip.isCompleted {
        Circle()
          .fill(MainColor.accent.swiftUIColor)
          .frame(
            width: Metric.checkCircleSize,
            height: Metric.checkCircleSize
          )
        Image(systemName: "checkmark")
          .font(.system(size: 12, weight: .bold))
          .foregroundStyle(.white)
      } else {
        Circle()
          .stroke(Color(.separator), lineWidth: 1.5)
          .frame(
            width: Metric.checkCircleSize,
            height: Metric.checkCircleSize
          )
      }
    }
    .animation(
      .spring(response: 0.3),
      value: self.tip.isCompleted
    )
  }
}
