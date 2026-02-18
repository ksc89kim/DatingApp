//
//  MatchingRouter.swift
//  AppStateInterface
//
//  Created by claude on 2/17/26.
//

import Foundation
import Util

public struct MatchingRouter: RouteType {

  // MARK: - Property

  public var paths: [MatchingRoutePath]

  public var navigationTransition: NavigationTransitionType

  // MARK: - Init

  public init(paths: [MatchingRoutePath] = []) {
    self.paths = paths
    self.navigationTransition = .slideUp
  }
}
