//
//  Router.swift
//  AppState
//
//  Created by kim sunchul on 2023/10/03.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import AppStateInterface

public struct Router: RouteType {

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
  ) {
    guard let key = key as? RouteKey else { return }
    switch key {
    case .main: self.main = paths.compactMap { route in route as? MainRoutePath }
    }
  }

  public mutating func append<Path: RoutePathType, Key: RouteKeyType>(path: Path, for key: Key) {
    guard let key = key as? RouteKey else { return }
    switch key {
    case .main: self.append(paths: &self.main, path: path as? MainRoutePath)
    }
  }

  public mutating func remove<Path: RoutePathType, Key: RouteKeyType>(path: Path, for key: Key) {
    guard let key = key as? RouteKey else { return }
    switch key {
    case .main: self.remove(paths: &self.main, path: path as? MainRoutePath)
    }
  }

  public mutating func removeAll<Key: RouteKeyType>(for key: Key) {
    guard let key = key as? RouteKey else { return }
    switch key {
    case .main: self.main.removeAll()
    }
  }
}
