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

  public var paths: [MainRoutePath]

  // MARK: - Init

  public init(paths: [MainRoutePath] = []) {
    self.paths = paths
  }
}
