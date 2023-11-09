//
//  EmptyRouter.swift
//  AppStateInterface
//
//  Created by kim sunchul on 11/9/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public struct EmptyRouter: RouteType {

  // MARK: - Property

  public var main: [MainRoutePath]

  // MARK: - Init

  public init(main: [MainRoutePath] = []) {
    self.main = main
  }

  // MARK: - Method

  public mutating func set<Path: RoutePathType, Key: RouteKeyType>(
    type: Path.Type,
    paths: [Path],
    for key: Key
  ) { }

  public mutating func append<Path: RoutePathType, Key: RouteKeyType>(path: Path, for key: Key) { }

  public mutating func remove<Path: RoutePathType, Key: RouteKeyType>(path: Path, for key: Key) { }

  public mutating func removeAll<Key: RouteKeyType>(for key: Key) { }
}
