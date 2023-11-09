//
//  MockRouter.swift
//  AppStateInterface
//
//  Created by kim sunchul on 2023/10/05.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import AppStateInterface

public struct MockRouter: RouteType {

  // MARK: - Property

  public var main: [MainRoutePath]

  public var mock: [MockRoutePath]

  // MARK: - Init

  public init(
    main: [MainRoutePath] = [],
    mock: [MockRoutePath] = []
  ) {
    self.main = main
    self.mock = mock
  }

  // MARK: - Method

  public mutating func set<Path: RoutePathType, Key: RouteKeyType>(
    type: Path.Type,
    paths: [Path],
    for key: Key
  ) {
    if let mockRouteKey = key as? MockRouteKey {
      switch mockRouteKey {
      case .mock: self.mock = paths.compactMap { route in route as? MockRoutePath }
      }
    } else if let routeKey = key as? RouteKey {
      switch routeKey {
      case .main: self.main = paths.compactMap { route in route as? MainRoutePath }
      }
    }
  }

  public mutating func append<Path: RoutePathType, Key: RouteKeyType>(path: Path, for key: Key) {
    if let mockRouteKey = key as? MockRouteKey {
      switch mockRouteKey {
      case .mock: self.append(paths: &self.mock, path: path as? MockRoutePath)
      }
    } else if let routeKey = key as? RouteKey {
      switch routeKey {
      case .main: self.append(paths: &self.main, path: path as? MainRoutePath)
      }
    }
  }

  public mutating func remove<Path: RoutePathType, Key: RouteKeyType>(path: Path, for key: Key) {
    if let mockRouteKey = key as? MockRouteKey {
      switch mockRouteKey {
      case .mock: self.remove(paths: &self.mock, path: path as? MockRoutePath)
      }
    } else if let routeKey = key as? RouteKey {
      switch routeKey {
      case .main: self.remove(paths: &self.main, path: path as? MainRoutePath)
      }
    }
  }

  public mutating func removeAll<Key: RouteKeyType>(for key: Key) {
    if let mockRouteKey = key as? MockRouteKey {
      switch mockRouteKey {
      case .mock: self.mock.removeAll()
      }
    } else if let routeKey = key as? RouteKey {
      switch routeKey {
      case .main: self.main.removeAll()
      }
    }
  }
}
