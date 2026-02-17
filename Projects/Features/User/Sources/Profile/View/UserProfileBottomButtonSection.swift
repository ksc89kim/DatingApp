//
//  UserProfileBottomButtonSection.swift
//  User
//
//  Created by kim sunchul on 2/15/26.
//

import SwiftUI
import Util
import UserInterface

struct UserProfileBottomButtonSection: View {

  // MARK: - Define

  private typealias MainColor = UtilAsset.MainColor

  private enum Metric {
    static let horizontalPadding: CGFloat = 18
    static let skipButtonSize: CGFloat = 56
    static let likeButtonSize: CGFloat = 64
    static let actionButtonSpacing: CGFloat = 24
    static let actionButtonBottomPadding: CGFloat = 24
    static let messageButtonHeight: CGFloat = 50
    static let messageButtonCornerRadius: CGFloat = 12
    static let editButtonHeight: CGFloat = 48
    static let editButtonCornerRadius: CGFloat = 12
    static let buttonVerticalPadding: CGFloat = 18
  }

  // MARK: - Property

  let entryType: UserProfileEntryType

  let onSkip: () -> Void

  let onLike: () -> Void

  let onOpenChat: () -> Void

  var body: some View {
    switch self.entryType {
    case .matchRecommend:
      self.matchRecommendButtons
    case .chatList:
      self.chatListButton
    case .myPage:
      self.editProfileButton
    }
  }
}


// MARK: - Private

private extension UserProfileBottomButtonSection {

  @ViewBuilder
  var matchRecommendButtons: some View {
    HStack(spacing: Metric.actionButtonSpacing) {
      Button {
        self.onSkip()
      } label: {
        Circle()
          .fill(Color(.systemBackground))
          .frame(
            width: Metric.skipButtonSize,
            height: Metric.skipButtonSize
          )
          .shadow(
            color: .black.opacity(0.1),
            radius: 8,
            y: 4
          )
          .overlay {
            Image(systemName: "xmark")
              .font(
                .system(size: 22, weight: .bold)
              )
              .foregroundStyle(.red)
          }
      }
      .buttonStyle(PressedButtonStyle())
      .accessibilityLabel("건너뛰기")

      Button {
        self.onLike()
      } label: {
        Circle()
          .fill(
            LinearGradient(
              colors: [
                Color(
                  red: 255 / 255,
                  green: 107 / 255,
                  blue: 157 / 255
                ),
                Color(
                  red: 194 / 255,
                  green: 57 / 255,
                  blue: 179 / 255
                ),
              ],
              startPoint: .topLeading,
              endPoint: .bottomTrailing
            )
          )
          .frame(
            width: Metric.likeButtonSize,
            height: Metric.likeButtonSize
          )
          .shadow(
            color: MainColor.accent.swiftUIColor
              .opacity(0.4),
            radius: 8,
            y: 4
          )
          .overlay {
            Image(systemName: "heart.fill")
              .font(
                .system(size: 26, weight: .bold)
              )
              .foregroundStyle(.white)
          }
      }
      .buttonStyle(PressedButtonStyle())
      .accessibilityLabel("좋아요")
    }
    .padding(
      .bottom,
      Metric.actionButtonBottomPadding
    )
  }

  @ViewBuilder
  var chatListButton: some View {
    Button {
      self.onOpenChat()
    } label: {
      HStack(spacing: 8) {
        Image(systemName: "message.fill")
          .font(.system(size: 16))
        Text("메시지 보내기")
          .systemScaledFont(
            style: .bottomButton
          )
      }
      .foregroundStyle(.white)
      .frame(maxWidth: .infinity)
      .frame(height: Metric.messageButtonHeight)
      .background(
        MainColor.accent.swiftUIColor
      )
      .clipShape(
        RoundedRectangle(
          cornerRadius: Metric
            .messageButtonCornerRadius
        )
      )
    }
    .buttonStyle(PressedButtonStyle())
    .accessibilityLabel("메시지 보내기")
    .padding(
      .horizontal,
      Metric.horizontalPadding
    )
    .padding(
      .vertical,
      Metric.buttonVerticalPadding
    )
  }

  @ViewBuilder
  var editProfileButton: some View {
    Button {
      // TODO: Navigate to edit profile
    } label: {
      Text("프로필 편집")
        .systemScaledFont(
          style: .bottomButton
        )
        .foregroundStyle(Color(.label))
        .frame(maxWidth: .infinity)
        .frame(height: Metric.editButtonHeight)
        .background(
          Color(.secondarySystemBackground)
        )
        .clipShape(
          RoundedRectangle(
            cornerRadius: Metric
              .editButtonCornerRadius
          )
        )
    }
    .buttonStyle(PressedButtonStyle())
    .accessibilityLabel("프로필 편집")
    .padding(
      .horizontal,
      Metric.horizontalPadding
    )
    .padding(
      .vertical,
      Metric.buttonVerticalPadding
    )
  }
}
