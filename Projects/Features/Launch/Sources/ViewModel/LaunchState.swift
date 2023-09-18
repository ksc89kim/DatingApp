//
//  LaunchState.swift
//  Launch
//
//  Created by kim sunchul on 2023/09/18.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import Util

public struct LaunchState {

  // MARK: - Property

  var alert: BaseAlert

  var isPresentAlert: Bool

  var completionCountMessage: String

  // MARK: - Init

  init(
    alert: BaseAlert = .empty,
    isPresentAlert: Bool = false,
    completionCountMessage: String = ""
  ) {
    self.alert = alert
    self.isPresentAlert = isPresentAlert
    self.completionCountMessage = completionCountMessage
  }
}
