//
//  LaunchAction.swift
//  Launch
//
//  Created by kim sunchul on 2023/09/18.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public enum LaunchAction {
  case run
  case runAsync
  case runAfterBuildForWoker
  case buildForWorker
  case clearCount
  case clearCountAsync
  case checkForceUpdate
}
