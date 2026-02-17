//
//  UserProfileImageSection.swift
//  User
//
//  Created by kim sunchul on 2/15/26.
//

import SwiftUI
import Util

struct UserProfileImageSection: View {

  // MARK: - Define

  private enum Metric {
    static let horizontalPadding: CGFloat = 18
    static let indicatorHeight: CGFloat = 3
    static let indicatorSpacing: CGFloat = 4
    static let indicatorTopPadding: CGFloat = 8
    static let indicatorSafeAreaExtra: CGFloat = 8
    static let indicatorHorizontalPadding: CGFloat = 12
    static let gradientRatio: CGFloat = 0.4
  }

  // MARK: - Property

  let imageURLs: [URL]

  @Binding
  var currentIndex: Int

  let nickname: String

  let age: Int?

  let height: String

  let job: String

  let imageHeight: CGFloat

  let safeAreaTop: CGFloat

  var body: some View {
    ZStack(alignment: .bottom) {
      ZStack(alignment: .top) {
        TabView(
          selection: self.$currentIndex
        ) {
          if self.imageURLs.isEmpty {
            ProfilePlaceHolder()
              .frame(
                maxWidth: .infinity,
                maxHeight: self.imageHeight
              )
              .tag(0)
          } else {
            ForEach(
              Array(self.imageURLs.enumerated()),
              id: \.offset
            ) { index, url in
              LoadImage<ProfilePlaceHolder>(
                url: url,
                placeHolderView: ProfilePlaceHolder()
              )
              .aspectRatio(contentMode: .fill)
              .frame(
                maxWidth: .infinity,
                minHeight: self.imageHeight,
                maxHeight: self.imageHeight
              )
              .clipped()
              .tag(index)
              .accessibilityLabel(
                "프로필 사진 \(self.imageURLs.count)장 중 \(index + 1)번째"
              )
              .accessibilityAddTraits(.isImage)
            }
          }
        }
        .frame(height: self.imageHeight)
        .tabViewStyle(
          .page(indexDisplayMode: .never)
        )

        self.imageIndicator(
          count: self.imageURLs.count
        )
      }

      self.gradientOverlay
      self.profileInfoOverlay
    }
  }
}


// MARK: - Private

private extension UserProfileImageSection {

  @ViewBuilder
  func imageIndicator(count: Int) -> some View {
    if count > 1 {
      HStack(spacing: Metric.indicatorSpacing) {
        ForEach(0..<count, id: \.self) { index in
          RoundedRectangle(cornerRadius: 1.5)
            .fill(
              index == self.currentIndex
                ? Color.white
                : Color.white.opacity(0.4)
            )
            .frame(height: Metric.indicatorHeight)
            .shadow(
              color: .black.opacity(0.4),
              radius: 2,
              x: 0,
              y: 1
            )
        }
      }
      .padding(
        .horizontal,
        Metric.indicatorHorizontalPadding
      )
      .padding(
        .top,
        self.safeAreaTop
          + Metric.indicatorSafeAreaExtra
      )
    }
  }

  var gradientOverlay: some View {
    LinearGradient(
      gradient: Gradient(colors: [
        .clear,
        .black.opacity(0.55),
      ]),
      startPoint: .center,
      endPoint: .bottom
    )
    .frame(
      height: self.imageHeight * Metric.gradientRatio
    )
    .allowsHitTesting(false)
  }

  var profileInfoOverlay: some View {
    VStack(alignment: .leading, spacing: 4) {
      HStack(alignment: .firstTextBaseline, spacing: 8) {
        Text(self.nickname)
          .systemScaledFont(font: .bold, size: 32)
          .foregroundStyle(.white)
          .accessibilityAddTraits(.isHeader)
        self.ageHeightOverlayText
      }
      if !self.job.isEmpty {
        HStack(spacing: 4) {
          Image(systemName: "briefcase.fill")
            .font(.system(size: 14))
            .foregroundStyle(.white.opacity(0.85))
          Text(self.job)
            .systemScaledFont(
              font: .regular,
              size: 16
            )
            .foregroundStyle(.white.opacity(0.85))
        }
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.horizontal, Metric.horizontalPadding)
    .padding(.bottom, 24)
  }

  @ViewBuilder
  var ageHeightOverlayText: some View {
    let parts = [
      self.age.map { "\($0)" },
      self.height.isEmpty ? nil : self.height,
    ].compactMap { $0 }

    if !parts.isEmpty {
      Text(parts.joined(separator: " · "))
        .systemScaledFont(font: .regular, size: 24)
        .foregroundStyle(.white.opacity(0.9))
    }
  }
}
