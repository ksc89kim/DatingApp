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

  var main: [MainRoutePath] { get set }

  mutating func set<Path: RoutePathType, Key: RouteKeyType>(
    type: Path.Type,
    paths: [Path],
    for key: Key
  )

  mutating func append<Path: RoutePathType, Key: RouteKeyType>(path: Path, for key: Key)

  mutating func remove<Path: RoutePathType, Key: RouteKeyType>(path: Path, for key: Key)

  mutating func removeAll<Key: RouteKeyType>(for key: Key)
}


public extension RouteType {

  func append<T: RoutePathType>(
    paths: inout [T],
    path: T?
  ) {
    guard let path = path else { return }
    paths.append(path)
  }

  func remove<T: RoutePathType>(
    paths: inout [T],
    path: T?
  ) {
    guard let path = path else { return }
    paths.removeAll { router in router == path }
  }
}
