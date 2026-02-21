//
//  MyPageRouter.swift
//  AppStateInterface
//
//  Created by kim sunchul on 2/21/26.
//

import Foundation
import Util

public struct MyPageRouter: RouteType {

  // MARK: - Property

  public var paths: [MyPageRoutePath]

  public var navigationTransition: NavigationTransitionType

  // MARK: - Init

  public init(paths: [MyPageRoutePath] = []) {
    self.paths = paths
    self.navigationTransition = .default
  }
}
