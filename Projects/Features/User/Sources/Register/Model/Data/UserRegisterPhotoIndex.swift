//
//  UserRegisterPhotoIndex.swift
//  User
//
//  Created by kim sunchul on 6/11/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation

enum UserRegisterPhotoIndex {
  case first
  case second
  
  var rawIndex: Int {
    switch self {
    case .first: return 0
    case .second: return 1
    }
  }
}
