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

  enum Main {
//
//    public static let background: Color = .init(hex: 0x800080)
//
//    public static let primary: Color = .init(hex: 0xFF1493)
//
//    public static let accent: Color = .init(hex: 0xFFA500)
//
//    public static let text: Color = .init(hex: 0xFFFFFF)

    public static let background: Color = .init(hex: 0x6A5ACD)

    public static let primary: Color = .init(hex: 0x90EE90)

    public static let accent: Color = .init(hex: 0xFFB6C1)

    public static let text: Color = .init(hex: 0xFFFFFF)
  }
}
