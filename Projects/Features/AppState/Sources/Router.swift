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

  public mutating func append(value: Any, for key: RouteKeyType) {
    guard let key = key as? RouteKey else { return }
    switch key {
    case .main: self.append(paths: &self.main, value: value)
    }
  }

  public mutating func remove(value: Any, for key: RouteKeyType) {
    guard let key = key as? RouteKey else { return }
    switch key {
    case .main: self.remove(paths: &self.main, value: value)
    }
  }
}
