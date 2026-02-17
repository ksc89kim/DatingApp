//
//  UserProfileLoadingOverlay.swift
//  User
//
//  Created by kim sunchul on 2/15/26.
//

import SwiftUI
import Util

struct UserProfileLoadingOverlay: View {

  // MARK: - Define

  private typealias MainColor = UtilAsset.MainColor

  // MARK: - Property

  let isLoading: Bool

  var body: some View {
    if self.isLoading {
      Color(.systemFill)
        .ignoresSafeArea()
        .overlay {
          ProgressView()
            .tint(MainColor.accent.swiftUIColor)
            .scaleEffect(1.5)
        }
        .allowsHitTesting(true)
    }
  }
}
