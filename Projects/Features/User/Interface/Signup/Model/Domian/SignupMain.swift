//
//  SignupMain.swift
//  User
//
//  Created by kim sunchul on 11/12/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import Core

public protocol SignupMain: ProgressMain {
  
  // MARK: - Property
  
  var repository: SignupRepositoryType? { get set }

  // MARK: - Method

  func mergeRequest(_ request: SignupRequest) -> SignupRequest
}
