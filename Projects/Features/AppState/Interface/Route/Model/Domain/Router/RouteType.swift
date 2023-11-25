//
//  RouteType.swift
//  AppStateInterface
//
//  Created by kim sunchul on 2023/10/05.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import DI

public protocol RouteType: Injectable {

  // MARK: - Define
  
  associatedtype Path: RoutePathType

  // MARK: - Property

  var paths: [Path] { get set }
}


// MARK: - Extension RouteType

public extension RouteType {
  
  var count: Int {
    return self.paths.count
  }

  var first: Path? {
    return self.paths.first
  }

  var isEmpty: Bool {
    return self.paths.isEmpty
  }

  mutating func set(paths: [Path]) {
    self.paths = paths
  }

  mutating func append(path: Path) {
    self.paths.append(path)
  }

  mutating func remove(path: Path) {
    self.paths.removeAll { route in route == path }
  }

  mutating func removeAll() {
    self.paths.removeAll()
  }

  mutating func popLast() -> Path? {
    return self.paths.popLast()
  }
}
