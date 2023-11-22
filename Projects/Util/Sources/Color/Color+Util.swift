//
//  Color+Util.swift
//  Util
//
//  Created by kim sunchul on 11/8/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI

public extension Color {

  init(hex: UInt, alpha: Double = 1) {
      self.init(
          .sRGB,
          red: Double((hex >> 16) & 0xff) / 255,
          green: Double((hex >> 08) & 0xff) / 255,
          blue: Double((hex >> 00) & 0xff) / 255,
          opacity: alpha
      )
  }
}
