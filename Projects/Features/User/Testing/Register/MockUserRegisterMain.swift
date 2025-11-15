//
//  MockUserRegisterMain.swift
//  UserTesting
//
//  Created by kim sunchul on 2/13/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation
import UserInterface

struct MockUserRegisterMain: UserRegisterMain {

  // MARK: - Property

  var isBottomDisable: Bool

  var title: String

  weak var repository: UserRegisterRepositoryType?

  // MARK: - Method

  func mergeRequest(_ request: UserRegisterRequest) -> UserRegisterRequest {
    return request
  }

  public func complete() { }
}
