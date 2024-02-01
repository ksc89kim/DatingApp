//
//  TimeInterval+Nanoseconds.swift
//  Util
//
//  Created by kim sunchul on 2/1/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation

public extension TimeInterval {
  
  var nanoseconds: UInt64 {
    return UInt64(self * 1_000_000_000)
  }
}
