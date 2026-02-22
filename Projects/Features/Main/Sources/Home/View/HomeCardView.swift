//
//  HomeCardView.swift
//  Main
//
//  Created by claude on 2/21/26.
//

import SwiftUI
import Util
import MatchingInterface

struct HomeCardView: View {

  // MARK: - Property

  let card: MatchingCardItem

  let onTap: () -> Void

  private var imageURL: URL? {
    guard let first = self.card.profileImages.first else {
      return nil
    }
    return URL(string: first)
  }

  // MARK: - Body

  var body: some View {
    Button(action: self.onTap) {
      GeometryReader { geometry in
        ZStack(alignment: .bottom) {
          self.imageSection(size: geometry.size)
          self.gradientOverlay
          self.infoSection
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
      }
      .aspectRatio(3 / 4, contentMode: .fit)
    }
    .buttonStyle(.plain)
  }

  // MARK: - Private

  @ViewBuilder
  private func imageSection(size: CGSize) -> some View {
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
      stops: [
        .init(color: .clear, location: 0.45),
        .init(color: .black.opacity(0.6), location: 1.0)
      ],
      startPoint: .top,
      endPoint: .bottom
    )
  }

  private var infoSection: some View {
    VStack(alignment: .leading, spacing: 4) {
      Spacer()
      Text(self.card.nickname)
        .systemScaledFont(style: .boldTitle)
        .foregroundStyle(.white)
      Text("\(self.card.age)세")
        .systemScaledFont(style: .caption)
        .foregroundStyle(.white)
        .padding(.horizontal, 8)
        .padding(.vertical, 3)
        .background(.white.opacity(0.25))
        .clipShape(Capsule())
    }
    .padding(12)
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}
