//
//  UserRegisterPictureView.swift
//  User
//
//  Created by kim sunchul on 5/4/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import SwiftUI
import Util

struct UserRegisterPictureView: View {
  
  // MARK: - Define
  
  enum Metric {
    static let cardSize: CGSize = .init(width: 150, height: 200)
  }
  
  // MARK: - Property
  
  @Binding
  var image: Image?
  
  let onAppend: () -> Void
  
  let onDelete: () -> Void
  
  var body: some View {
    Group {
      if let image = self.image {
        self.profileImageButton(image)
      } else {
        self.placeHolderButton
      }
    }
    .frame(maxWidth: Metric.cardSize.width, maxHeight: Metric.cardSize.height)
    .contentShape(Rectangle())
    .clipShape(RoundedRectangle(cornerRadius: 12))
  }
  
  @ViewBuilder
  var placeHolderButton: some View {
    Button(
      action: self.onAppend,
      label: {
        RoundedRectangle(cornerRadius: 12)
          .foregroundStyle(
            UserAsset
              .Assets
              .registerGalleryPictureBackground
              .swiftUIColor
          )
          .overlay {
            ZStack {
              Image(systemName: "camera.fill")
                .resizable()
                .frame(width: 31, height: 24)
                .foregroundStyle(UserAsset.Assets.registerGalleryPictureCamera.swiftUIColor)
              VStack {
                Spacer()
                HStack {
                  Spacer()
                  Circle()
                    .foregroundStyle(.white)
                    .frame(width: 24, height: 24)
                    .overlay(
                      Image(systemName: "plus")
                        .font(.system(size: 12, weight: .bold)),
                      alignment: .center
                    )
                }
                .padding(20)
              }
            }
          }
      }
    )
    .buttonStyle(PressedButtonStyle())
  }
  
  @ViewBuilder
  private func profileImageButton(_ image: Image) -> some View {
    ZStack(alignment: .topTrailing) {
      image
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(maxWidth: Metric.cardSize.width, maxHeight: Metric.cardSize.height)
      Button(
        action: self.onDelete,
        label: {
          Image(systemName: "xmark.circle.fill")
            .foregroundStyle(UtilAsset.MainColor.accent.swiftUIColor)
            .font(.system(size: 24, weight: .bold))
        }
      )
      .buttonStyle(.plain)
      .padding(.top, 6)
      .padding(.trailing, 6)
    }
  }
}


#Preview {
  UserRegisterPictureView(
    image: .constant(nil),
    onAppend: {},
    onDelete: {}
  )
}
