//
//  ScaledFont.swift
//  Util
//
//  Created by kim sunchul on 11/22/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI

struct ScaledFontModifier: ViewModifier {

  // MARK: - Property

  @Environment(\.sizeCategory) var sizeCategory

  var font: Fontable

  var size: CGFloat

  // MARK: - Method

  func body(content: Content) -> some View {
    let scaledSize = UIFontMetrics.default.scaledValue(for: self.size)
    return content.font(self.font.size(scaledSize))
  }
}


// MARK: - View

public extension View {

  // MARK: - Method
  
  func scaledFont<Font: Fontable>(font: Font, size: CGFloat) -> some View {
    return self.modifier(ScaledFontModifier(font: font, size: size))
  }

  func scaledFont<Style: FontStyle>(style: Style) -> some View {
    return self.scaledFont(font: style.font, size: style.size)
  }

  func systemScaledFont(font: SystemFont, size: CGFloat) -> some View {
    return self.scaledFont(font: font, size: size)
  }

  func systemScaledFont(style: SystemFont.Style) -> some View {
    return self.scaledFont(style: style)
  }
}
