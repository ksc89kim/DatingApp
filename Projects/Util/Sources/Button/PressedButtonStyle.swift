//
//  PressedButtonStyle.swift
//  Util
//
//  Created by kim sunchul on 11/11/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI

public struct PressedButtonStyle: ButtonStyle {

  // MARK: - Init

  public init() {}

  // MARK: - Method

  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
      .animation(.easeInOut(duration: 0.25), value: configuration.isPressed)
  }
}
