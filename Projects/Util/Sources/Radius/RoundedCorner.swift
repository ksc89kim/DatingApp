//
//  RoundedCorner.swift
//  Util
//
//  Created by kim sunchul on 1/5/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import SwiftUI

public struct RoundedCorner: Shape {

  // MARK: - Property

  var radius: CGFloat = .infinity

  var corners: UIRectCorner = .allCorners

  // MARK: - Method
  
  public func path(in rect: CGRect) -> Path {
    let path: UIBezierPath = .init(
      roundedRect: rect,
      byRoundingCorners: self.corners,
      cornerRadii: CGSize(width: self.radius, height: self.radius)
    )

    return Path(path.cgPath)
  }
}


// MARK: - View

public extension View {

  func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
    clipShape(RoundedCorner(radius: radius, corners: corners))
  }
}
