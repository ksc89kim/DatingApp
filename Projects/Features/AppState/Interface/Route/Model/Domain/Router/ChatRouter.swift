//
//  ChatRouter.swift
//  AppStateInterface
//
//  Created by kim sunchul on 11/26/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import Util

public struct ChatRouter: RouteType {

  // MARK: - Property

  public var paths: [ChatRoutePath]

  public var navigationTransition: NavigationTransitionType

  // MARK: - Init

  public init(paths: [ChatRoutePath] = []) {
    self.paths = paths
      self.navigationTransition = .default
  }
}
