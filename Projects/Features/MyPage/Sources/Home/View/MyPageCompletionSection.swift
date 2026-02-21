//
//  MyPageCompletionSection.swift
//  MyPage
//
//  Created by kim sunchul on 2/21/26.
//

import SwiftUI
import Util

struct MyPageCompletionSection: View {

  // MARK: - Define

  private typealias MainColor = UtilAsset.MainColor

  private enum Metric {
    static let progressHeight: CGFloat = 6
    static let progressCornerRadius: CGFloat = 3
    static let cardPadding: CGFloat = 16
    static let cardCornerRadius: CGFloat = 16
    static let horizontalMargin: CGFloat = 16
    static let tipsSpacing: CGFloat = 8
  }

  // MARK: - Property

  let completionPercentage: Int

  let completionTips: [ProfileCompletionTip]

  let onTapTip: (String) -> Void

  // MARK: - State

  @State private var animatedWidth: CGFloat = 0

  @State private var isVisible: Bool = false

  // MARK: - Body

  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      self.progressBar
      Text("프로필을 채워 더 많이 노출되세요")
        .systemScaledFont(font: .regular, size: 14)
        .foregroundStyle(Color(.secondaryLabel))

      if !self.completionTips.isEmpty {
        VStack(spacing: Metric.tipsSpacing) {
          ForEach(self.completionTips) { tip in
            MyPageCompletionTipRow(tip: tip) {
              self.onTapTip(tip.id)
            }
          }
        }
      }
    }
    .padding(Metric.cardPadding)
    .background(Color(.systemBackground))
    .clipShape(RoundedRectangle(cornerRadius: Metric.cardCornerRadius))
    .padding(.horizontal, Metric.horizontalMargin)
    .opacity(self.isVisible ? 1 : 0)
    .offset(y: self.isVisible ? 0 : 20)
    .onAppear {
      withAnimation(.easeOut(duration: 0.4).delay(0.1)) {
        self.isVisible = true
      }
      withAnimation(.spring(response: 0.8, dampingFraction: 0.7)) {
        self.animatedWidth = CGFloat(self.completionPercentage) / 100.0
      }
    }
  }

  // MARK: - Private

  private var progressBar: some View {
    HStack(spacing: 12) {
      GeometryReader { geo in
        ZStack(alignment: .leading) {
          RoundedRectangle(cornerRadius: Metric.progressCornerRadius)
            .fill(Color(.systemFill))
            .frame(height: Metric.progressHeight)

          RoundedRectangle(cornerRadius: Metric.progressCornerRadius)
            .fill(
              LinearGradient(
                colors: [
                  MyPageAsset.MyPageColor.completionPink.swiftUIColor,
                  MainColor.accent.swiftUIColor
                ],
                startPoint: .leading,
                endPoint: .trailing
              )
            )
            .frame(
              width: self.animatedWidth * geo.size.width,
              height: Metric.progressHeight
            )
        }
        .frame(maxHeight: .infinity, alignment: .center)
      }
      .frame(height: Metric.progressHeight)

      Text("\(self.completionPercentage)%")
        .systemScaledFont(font: .bold, size: 12)
        .foregroundStyle(Color(.systemBackground))
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color(.label))
        .clipShape(Capsule())
    }
  }
}
