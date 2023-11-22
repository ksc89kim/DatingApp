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
