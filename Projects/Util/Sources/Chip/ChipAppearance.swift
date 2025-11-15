//
//  ChipAppearance.swift
//  Util
//
//  Created by kim sunchul on 2/17/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation
import SwiftUI

public struct ChipAppearance {
  
  // MARK: - Property
  
  public let cornerRadius: CGFloat
  
  public let edges: EdgeInsets
  
  public let font: SystemFont
  
  public let fontSize: CGFloat
  
  public let selectedBackgroundColor: Color
  
  public let unselectedBackgroundColor: Color

  public let selectedForegroundColor: Color
  
  public let unselectedForegroundColor: Color
  
  // MARK: - Init
  
  public init(
    cornerRadius: CGFloat = 20,
    edges: EdgeInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16),
    font: SystemFont = .regular,
    fontSize: CGFloat = 15,
    selectedBackgroundColor: Color = .black,
    unselectedBackgroundColor: Color = .gray.opacity(0.2),
    selectedForegroundColor: Color = .white,
    unselectedForegroundColor: Color = .black
  ) {
    self.cornerRadius = cornerRadius
    self.edges = edges
    self.font = font
    self.fontSize = fontSize
    self.selectedBackgroundColor = selectedBackgroundColor
    self.unselectedBackgroundColor = unselectedBackgroundColor
    self.selectedForegroundColor = selectedForegroundColor
    self.unselectedForegroundColor = unselectedForegroundColor
  }
  
  // MARK: - Method
  
  func backgroundColor(isSelected: Bool) -> Color {
    if isSelected {
      return self.selectedBackgroundColor
    } else {
      return self.unselectedBackgroundColor
    }
  }
  
  func foregroundColor(isSelected: Bool) -> Color {
    if isSelected {
      return self.selectedForegroundColor
    } else {
      return self.unselectedForegroundColor
    }
  }
}
