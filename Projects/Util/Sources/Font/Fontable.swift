//
//  Fontable.swift
//  Util
//
//  Created by kim sunchul on 11/22/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI

public protocol Fontable {

  // MARK: - Property

  var weight: Font.Weight { get }

  var isSystem: Bool { get }

  // MARK: - Method

  func size(_ size: CGFloat) -> Font
}


// MARK: - Fontable Extension

public extension Fontable {

  var isSystem: Bool { return false }
}


// MARK: - RawRepresentable

public extension Fontable where Self: RawRepresentable, Self.RawValue == String {

  func size(_ size: CGFloat) -> Font {
    if self.isSystem {
      return .system(size: size, weight: self.weight)
    } else {
      return .custom(self.rawValue, size: size)
    }
  }
}
