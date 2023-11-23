//
//  MockRouter.swift
//  AppStateInterface
//
//  Created by kim sunchul on 2023/10/05.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import AppStateInterface

struct MockRouter: RouteType {

  // MARK: - Property

  public var main: [MainRoutePath]

  public var chat: [ChatRoutePath]

  public var mock: [MockRoutePath]

  private var router: Router

  // MARK: - Init

  init(
    main: [MainRoutePath] = [],
    chat: [ChatRoutePath] = [],
    mock: [MockRoutePath] = []
  ) {
    self.main = main
    self.chat = chat
    self.mock = mock
    self.router = .init(main: main, chat: chat)
  }

  // MARK: - Method

  mutating func set<Path: RoutePathType, Key: RouteKeyType>(
    type: Path.Type,
    paths: [Path],
    for key: Key
  ) {
    if let mockRouteKey = key as? MockRouteKey {
      switch mockRouteKey {
      case .mock: self.mock = paths.compactMap { route in route as? MockRoutePath }
      }
    } else if let routeKey = key as? RouteKey {
      self.router.set(type: type, paths: paths, for: key)
      self.syncFromRouter()
    }
  }

  mutating func append<Path: RoutePathType, Key: RouteKeyType>(path: Path, for key: Key) {
    if let mockRouteKey = key as? MockRouteKey {
      switch mockRouteKey {
      case .mock: self.append(paths: &self.mock, path: path as? MockRoutePath)
      }
    } else if let routeKey = key as? RouteKey {
      self.router.append(path: path, for: key)
      self.syncFromRouter()
    }
  }

  mutating func remove<Path: RoutePathType, Key: RouteKeyType>(path: Path, for key: Key) {
    if let mockRouteKey = key as? MockRouteKey {
      switch mockRouteKey {
      case .mock: self.remove(paths: &self.mock, path: path as? MockRoutePath)
      }
    } else if let routeKey = key as? RouteKey {
      self.router.remove(path: path, for: key)
      self.syncFromRouter()
    }
  }

  mutating func removeAll<Key: RouteKeyType>(for key: Key) {
    if let mockRouteKey = key as? MockRouteKey {
      switch mockRouteKey {
      case .mock: self.mock.removeAll()
      }
    } else if let routeKey = key as? RouteKey {
      self.router.removeAll(for: key)
      self.syncFromRouter()
    }
  }

  private mutating func syncFromRouter() {
    self.main = self.router.main
    self.chat = self.router.chat
  }
}
