//
//  Router.swift
//  AppState
//
//  Created by kim sunchul on 2023/10/03.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public struct Router {

  public enum Key {
    case main
  }

  // MARK: - Property

  public var main: [MainRoutePath]

  // MARK: - Init

  init(main: [MainRoutePath] = [.launch]) {
    self.main = main
  }

  // MARK: - Method

  public mutating func append(value: Any, for key: Key) {
    switch key {
    case .main: self.append(paths: &self.main, value: value)
    }
  }

  private func append<T>(
    paths: inout [T],
    value: Any
  ) {
    guard let value = value as? T else { return }
    paths.append(value)
  }

  public mutating func remove(value: Any, for key: Key) {
    switch key {
    case .main: self.remove(paths: &self.main, value: value)
    }
  }

  private func remove<T: Equatable>(
    paths: inout [T],
    value: Any
  ) {
    guard let value = value as? T else { return }
    paths.removeAll { router in router == value }
  }
}
