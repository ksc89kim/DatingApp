//
//  MatchingCardView.swift
//  Matching
//
//  Created by claude on 2/17/26.
//

import SwiftUI
import Util
import MatchingInterface

struct MatchingCardView: View {

  // MARK: - Property

  let card: MatchingCardItem

  let isTop: Bool

  let onSwipe: (SwipeDirection) -> Void

  let onTap: () -> Void

  @State
  private var offset: CGSize = .zero

  @State
  private var isRemoved: Bool = false

  private var imageURL: URL? {
    guard let first = self.card.profileImages.first else {
      return nil
    }
    return URL(string: first)
  }

  // MARK: - Body

  var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .bottom) {
        self.profileImageSection(size: geometry.size)
        self.gradientOverlay
        self.userInfoSection
        self.swipeStampSection
      }
      .clipShape(RoundedRectangle(cornerRadius: 16))
      .shadow(radius: 4)
      .offset(x: self.offset.width, y: self.offset.height * 0.4)
      .rotationEffect(
        .degrees(Double(self.offset.width / 40))
      )
      .gesture(self.isTop ? self.dragGesture(size: geometry.size) : nil)
      .onTapGesture {
        if self.isTop {
          self.onTap()
        }
      }
    }
  }

  // MARK: - Private

  @ViewBuilder
  private func profileImageSection(size: CGSize) -> some View {
    LoadImage(
      url: self.imageURL,
      placeHolderView: ProfilePlaceHolder()
    )
    .scaledToFill()
    .frame(width: size.width, height: size.height)
    .clipped()
  }

  private var gradientOverlay: some View {
    LinearGradient(
      gradient: Gradient(colors: [.clear, .black.opacity(0.6)]),
      startPoint: .center,
      endPoint: .bottom
    )
  }

  private var userInfoSection: some View {
    VStack(alignment: .leading, spacing: 4) {
      Spacer()
      HStack(alignment: .firstTextBaseline) {
        Text(self.card.nickname)
          .systemScaledFont(style: .boldTitle)
          .foregroundStyle(.white)
        Text("\(self.card.age)")
          .systemScaledFont(style: .body)
          .foregroundStyle(.white.opacity(0.9))
      }
      if !self.card.job.isEmpty {
        Text(self.card.job)
          .systemScaledFont(style: .text)
          .foregroundStyle(.white.opacity(0.8))
      }
    }
    .padding(20)
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  private var swipeStampSection: some View {
    ZStack {
      // LIKE 스탬프 (오른쪽 스와이프)
      Text("LIKE")
        .font(.system(size: 48, weight: .bold))
        .foregroundStyle(.green)
        .padding(8)
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .stroke(.green, lineWidth: 4)
        )
        .rotationEffect(.degrees(-15))
        .offset(x: -60, y: -200)
        .opacity(self.likeOpacity)

      // NOPE 스탬프 (왼쪽 스와이프)
      Text("NOPE")
        .font(.system(size: 48, weight: .bold))
        .foregroundStyle(.red)
        .padding(8)
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .stroke(.red, lineWidth: 4)
        )
        .rotationEffect(.degrees(15))
        .offset(x: 60, y: -200)
        .opacity(self.nopeOpacity)
    }
  }

  private var likeOpacity: Double {
    guard self.offset.width > 0 else { return 0 }
    return min(Double(self.offset.width) / 100, 1.0)
  }

  private var nopeOpacity: Double {
    guard self.offset.width < 0 else { return 0 }
    return min(Double(abs(self.offset.width)) / 100, 1.0)
  }

  private func dragGesture(size: CGSize) -> some Gesture {
    DragGesture()
      .onChanged { value in
        self.offset = value.translation
      }
      .onEnded { value in
        let threshold: CGFloat = 100
        if value.translation.width > threshold {
          withAnimation(.easeOut(duration: 0.3)) {
            self.offset = CGSize(
              width: size.width * 2,
              height: value.translation.height
            )
          }
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.onSwipe(.right)
            self.offset = .zero
          }
        } else if value.translation.width < -threshold {
          withAnimation(.easeOut(duration: 0.3)) {
            self.offset = CGSize(
              width: -size.width * 2,
              height: value.translation.height
            )
          }
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.onSwipe(.left)
            self.offset = .zero
          }
        } else {
          withAnimation(.spring()) {
            self.offset = .zero
          }
        }
      }
  }
}
