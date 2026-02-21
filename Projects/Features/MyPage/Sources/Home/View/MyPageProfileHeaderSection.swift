//
//  MyPageProfileHeaderSection.swift
//  MyPage
//
//  Created by kim sunchul on 2/21/26.
//

import SwiftUI
import Util

struct MyPageProfileHeaderSection: View {

  // MARK: - Define

  private typealias MainColor = UtilAsset.MainColor

  private enum Metric {
    static let imageSize: CGFloat = 80
    static let imageStroke: CGFloat = 2
    static let settingButtonSize: CGFloat = 36
    static let settingIconSize: CGFloat = 22
    static let editButtonHeight: CGFloat = 44
    static let cardPadding: CGFloat = 16
    static let cardCornerRadius: CGFloat = 16
    static let horizontalMargin: CGFloat = 16
  }

  // MARK: - Property

  let nickname: String

  let isVerified: Bool

  let profileImageURL: String?

  let onTapEdit: () -> Void

  let onTapSetting: () -> Void

  // MARK: - Body

  var body: some View {
    VStack(spacing: 12) {
      self.topRow
      self.editButton
    }
    .padding(Metric.cardPadding)
    .background(Color(.systemBackground))
    .clipShape(RoundedRectangle(cornerRadius: Metric.cardCornerRadius))
    .padding(.horizontal, Metric.horizontalMargin)
  }

  // MARK: - Private

  private var topRow: some View {
    HStack(spacing: 12) {
      self.profileImage
      self.nameSection
      Spacer()
      self.settingButton
    }
  }

  private var profileImage: some View {
    LoadImage<ProfilePlaceHolder>(
      url: URL(string: self.profileImageURL ?? ""),
      placeHolderView: ProfilePlaceHolder()
    )
    .aspectRatio(contentMode: .fill)
    .frame(
      width: Metric.imageSize,
      height: Metric.imageSize
    )
    .clipShape(Circle())
    .overlay(
      Circle()
        .stroke(
          MainColor.accent.swiftUIColor,
          lineWidth: Metric.imageStroke
        )
    )
  }

  private var nameSection: some View {
    HStack(spacing: 6) {
      Text(self.nickname)
        .systemScaledFont(font: .bold, size: 22)
        .foregroundStyle(Color(.label))
      Image(systemName: "checkmark.seal.fill")
        .font(.system(size: 18))
        .foregroundStyle(
          self.isVerified
            ? MyPageAsset.MyPageColor.verifyBadgeBlue.swiftUIColor
            : Color(.tertiaryLabel)
        )
    }
  }

  private var settingButton: some View {
    Button(action: self.onTapSetting) {
      Image(systemName: "gearshape.fill")
        .font(.system(size: Metric.settingIconSize))
        .foregroundStyle(Color(.secondaryLabel))
        .frame(
          width: Metric.settingButtonSize,
          height: Metric.settingButtonSize
        )
        .background(Color(.secondarySystemFill))
        .clipShape(Circle())
    }
    .buttonStyle(PressedButtonStyle())
  }

  private var editButton: some View {
    Button(action: self.onTapEdit) {
      HStack(spacing: 6) {
        Image(systemName: "pencil")
          .font(.system(size: 14))
        Text("프로필 수정")
          .systemScaledFont(font: .semibold, size: 15)
      }
      .foregroundStyle(Color(.systemBackground))
      .frame(maxWidth: .infinity)
      .frame(height: Metric.editButtonHeight)
      .background(Color(.label))
      .clipShape(Capsule())
    }
    .buttonStyle(PressedButtonStyle())
  }
}
