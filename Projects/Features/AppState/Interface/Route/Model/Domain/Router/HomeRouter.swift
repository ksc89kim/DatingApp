//
//  HomeRouter.swift
//  AppStateInterface
//
//  Created by claude on 2/21/26.
//

import Foundation
import Util

public struct HomeRouter: RouteType {

  // MARK: - Property

  public var paths: [HomeRoutePath]

  public var navigationTransition: NavigationTransitionType

  // MARK: - Init

  public init(paths: [HomeRoutePath] = []) {
    self.paths = paths
    self.navigationTransition = .default
  }
}
