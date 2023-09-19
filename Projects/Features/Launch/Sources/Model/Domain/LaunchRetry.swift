//
//  LaunchRetry.swift
//  Launch
//
//  Created by kim sunchul on 2023/09/19.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

struct LaunchRetry {

  // MARK: - Property

  var limit: Int

  private(set) var count: Int

  var isRetryPossible: Bool {
    return self.count < self.limit
  }

  var isNotRetry: Bool {
    return self.count <= 0
  }

  // MARK: - Init

  init(
    limitCount: Int = .max,
    retryCount: Int = 0
  ) {
    self.limit = limitCount
    self.count = retryCount
  }

  // MARK: - Method

  mutating func add() {
    self.count += 1
  }

  mutating func clear() {
    self.count = 0
    self.limit = .max
  }
}
