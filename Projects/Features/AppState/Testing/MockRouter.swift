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

  public mutating func append(value: Any, for key: RouteKeyType) {
    guard let key = key as? MockRouteKey else { return }
    switch key {
    case .main: self.append(paths: &self.main, value: value)
    case .mock: self.append(paths: &self.mock, value: value)
    }
  }

  public mutating func remove(value: Any, for key: RouteKeyType) {
    guard let key = key as? MockRouteKey else { return }
    switch key {
    case .main: self.remove(paths: &self.main, value: value)
    case .mock: self.remove(paths: &self.mock, value: value)
    }
  }
}
