//
//  UserRegisterRepositoryType.swift
//  UserInterface
//
//  Created by kim sunchul on 2/11/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation
import DI

public protocol UserRegisterRepositoryType: AnyObject, Injectable {

  // MARK: - Method

  func register(request: UserRegisterRequest) async throws
}
