//
//  MockRouter.swift
//  AppStateInterface
//
//  Created by kim sunchul on 2023/10/05.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import Util
import AppStateInterface

struct MockRouter: RouteType {

  // MARK: - Property

  var paths: [MockRoutePath]

  var navigationTransition: NavigationTransitionType

  // MARK: - Init

  init(
    paths: [MockRoutePath] = [],
    navigationTransition: NavigationTransitionType = .default
  ) {
    self.paths = paths
    self.navigationTransition = navigationTransition
  }
}
