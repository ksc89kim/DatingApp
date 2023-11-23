//
//  Router.swift
//  AppState
//
//  Created by kim sunchul on 2023/10/03.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public struct Router: RouteType {

  // MARK: - Property

  public var main: [MainRoutePath]

  public var chat: [ChatRoutePath]

  // MARK: - Init

  public init(
    main: [MainRoutePath] = [],
    chat: [ChatRoutePath] = []
  ) {
    self.main = main
    self.chat = chat
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
    case .chat: self.chat = paths.compactMap { route in route as? ChatRoutePath }
    }
  }

  public mutating func append<Path: RoutePathType, Key: RouteKeyType>(path: Path, for key: Key) {
    guard let key = key as? RouteKey else { return }
    switch key {
    case .main: self.append(paths: &self.main, path: path as? MainRoutePath)
    case .chat: self.append(paths: &self.chat, path: path as? ChatRoutePath)
    }
  }

  public mutating func remove<Path: RoutePathType, Key: RouteKeyType>(path: Path, for key: Key) {
    guard let key = key as? RouteKey else { return }
    switch key {
    case .main: self.remove(paths: &self.main, path: path as? MainRoutePath)
    case .chat: self.remove(paths: &self.chat, path: path as? ChatRoutePath)
    }
  }

  public mutating func removeAll<Key: RouteKeyType>(for key: Key) {
    guard let key = key as? RouteKey else { return }
    switch key {
    case .main: self.main.removeAll()
    case .chat: self.chat.removeAll()
    }
  }
}
