//
//  UserRegisterMain.swift
//  UserInterface
//
//  Created by kim sunchul on 2/11/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation
import Core

public protocol UserRegisterMain: ProgressMain {
  
  // MARK: - Property
  
  var repository: UserRegisterRepositoryType? { get set }

  // MARK: - Method
  
  func mergeRequest(_ request: UserRegisterRequest) -> UserRegisterRequest
}
