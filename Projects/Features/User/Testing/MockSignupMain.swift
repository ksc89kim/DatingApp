//
//  MockSignupMain.swift
//  UserTesting
//
//  Created by kim sunchul on 11/13/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import UserInterface

struct MockSignupMain: SignupMain {

  // MARK: - Property

  var isBottomDisable: Bool

  var title: String

  // MARK: - Method

  func mergeRequest(_ request: SignupRequest) -> SignupRequest {
    return request
  }

  public func complete() { }
}
