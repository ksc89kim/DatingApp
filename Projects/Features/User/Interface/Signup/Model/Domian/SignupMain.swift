//
//  SignupMain.swift
//  User
//
//  Created by kim sunchul on 11/12/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public protocol SignupMain {

  // MARK: - Property
  
  var isBottomDisable: Bool { get set }

  var repository: SignupRepositoryType? { get set }

  // MARK: - Method

  func complete()

  func mergeRequest(_ request: SignupRequest) -> SignupRequest
}
