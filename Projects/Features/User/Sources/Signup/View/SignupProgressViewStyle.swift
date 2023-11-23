//
//  SignupProgressViewStyle.swift
//  UserInterface
//
//  Created by kim sunchul on 11/9/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI
import Util

struct SignupProgressViewStyle: ProgressViewStyle {

  // MARK: - Property

  var height: Double = 18

  var isAnimation: Bool = false

  // MARK: - Method

  func makeBody(configuration: Configuration) -> some View {

    let progress = configuration.fractionCompleted ?? 0.0

    return GeometryReader { geometry in
      RoundedRectangle(cornerRadius: self.height / 2)
        .foregroundColor(Color(hex: 0xe0e0e0))
        .frame(height: self.height)
        .frame(width: geometry.size.width)
        .overlay(alignment: .leading) {
          RoundedRectangle(cornerRadius: self.height / 2)
            .fill(UtilAsset.MainColor.background.swiftUIColor)
            .frame(width: geometry.size.width * progress)
            .animation(.easeOut, value: self.isAnimation ? progress : 0 )
        }
    }
    .frame(height: self.height)
  }
}
