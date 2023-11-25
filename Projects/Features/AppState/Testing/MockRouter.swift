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

  var paths: [MockRoutePath]

  // MARK: - Init

  init(paths: [MockRoutePath] = []) {
    self.paths = paths
  }
}
