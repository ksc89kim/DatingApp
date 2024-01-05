//
//  SystemFont.swift
//  Util
//
//  Created by kim sunchul on 11/22/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import SwiftUI

public enum SystemFont: String, Fontable {
  case bold
  case semibold
  case ultraLight
  case thin
  case light
  case regular
  case medium
  case heavy
  case black

  // MARK: - Property

  public var weight: Font.Weight {
    switch self {
    case .bold: .bold
    case .semibold: .semibold
    case .ultraLight: .ultraLight
    case .thin: .thin
    case .light: .light
    case .regular: .regular
    case .medium: .medium
    case .heavy: .heavy
    case .black: .black
    }
  }
  
  public var isSystem: Bool { return true }
}


// MARK: - Style

public extension SystemFont {

  enum Style: FontStyle {
    case boldLargeTitle
    case boldTitle
    case semiboldTitle
    case body
    case placeHolder
    case bottomButton
    case logo
    case text

    // MARK: - Property

    public var font: SystemFont {
      switch self {
      case .boldLargeTitle: .bold
      case .boldTitle: .bold
      case .semiboldTitle: .semibold
      case .body: .regular
      case .placeHolder: .regular
      case .bottomButton: .bold
      case .logo: .bold
      case .text: .medium
      }
    }

    public var size: CGFloat {
      switch self {
      case .boldLargeTitle: 28
      case .boldTitle: 22
      case .semiboldTitle: 22
      case .body: 17
      case .placeHolder: 12
      case .bottomButton: 14
      case .logo: 32
      case .text: 14
      }
    }
  }
}
