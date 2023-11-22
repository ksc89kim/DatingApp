//
//  FontStyle.swift
//  Util
//
//  Created by kim sunchul on 11/22/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public protocol FontStyle {
  
  // MARK: - Define
  
  associatedtype Font: Fontable

  // MARK: - Property

  var font: Font { get }

  var size: CGFloat { get }
}
