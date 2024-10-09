//
//  EntranceRouter.swift
//  AppState
//
//  Created by kim sunchul on 2023/10/03.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import Util
import SwiftUI

public struct EntranceRouter: RouteType {

  // MARK: - Property

  public var paths: [EntranceRoutePath]

  public var navigationTransition: NavigationTransition

  // MARK: - Init

  public init(paths: [EntranceRoutePath] = []) {
    self.paths = paths
    self.navigationTransition = .fadeCross
  }

  public mutating func goMain() {
    withAnimation {
      self.removeAll()
    }
  }
}
