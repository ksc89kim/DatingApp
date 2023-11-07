//
//  TokenManagerType.swift
//  Core
//
//  Created by kim sunchul on 10/31/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public protocol TokenManagerType {
  
  // MARK: - Method

  func save(token: String?)

  func accessToken() -> String?
}
