//
//  MatchSuccessOverlayView.swift
//  Matching
//
//  Created by claude on 2/17/26.
//

import SwiftUI
import Util
import MatchingInterface

struct MatchSuccessOverlayView: View {

  // MARK: - Property

  let matchedUser: MatchingCardItem

  let onSendMessage: () -> Void

  let onContinue: () -> Void

  @State
  private var isAnimating: Bool = false

  private var imageURL: URL? {
    guard let first = self.matchedUser.profileImages.first else {
      return nil
    }
    return URL(string: first)
  }

  // MARK: - Body

  var body: some View {
    ZStack {
      Color.black.opacity(0.7)
        .ignoresSafeArea()
        .onTapGesture {
          self.onContinue()
        }

      VStack(spacing: 24) {
        self.profileImageSection
        self.titleSection
        self.buttonSection
      }
      .scaleEffect(self.isAnimating ? 1.0 : 0.5)
      .opacity(self.isAnimating ? 1.0 : 0.0)
    }
    .onAppear {
      withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
        self.isAnimating = true
      }
    }
  }

  // MARK: - Private

  private var profileImageSection: some View {
    LoadImage(
      url: self.imageURL,
      placeHolderView: ProfilePlaceHolder()
    )
    .scaledToFill()
    .frame(width: 120, height: 120)
    .clipShape(Circle())
    .overlay(
      Circle()
        .stroke(.white, lineWidth: 4)
    )
    .shadow(radius: 8)
  }

  private var titleSection: some View {
    VStack(spacing: 8) {
      Text("매치 성공!")
        .font(.system(size: 32, weight: .bold))
        .foregroundStyle(.white)

      Text("\(self.matchedUser.nickname)님과 매치되었습니다")
        .systemScaledFont(style: .body)
        .foregroundStyle(.white.opacity(0.9))
    }
  }

  private var buttonSection: some View {
    VStack(spacing: 12) {
      Button {
        self.onSendMessage()
      } label: {
        Text("메시지 보내기")
          .systemScaledFont(style: .bottomButton)
          .foregroundStyle(.white)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 14)
          .background(UtilAsset.MainColor.background.swiftUIColor)
          .clipShape(Capsule())
      }
      .buttonStyle(PressedButtonStyle())

      Button {
        self.onContinue()
      } label: {
        Text("계속하기")
          .systemScaledFont(style: .bottomButton)
          .foregroundStyle(.white.opacity(0.8))
          .frame(maxWidth: .infinity)
          .padding(.vertical, 14)
          .background(.white.opacity(0.2))
          .clipShape(Capsule())
      }
      .buttonStyle(PressedButtonStyle())
    }
    .padding(.horizontal, 40)
  }
}
