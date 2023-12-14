//
//  SignupRepositoryType.swift
//  UserInterface
//
//  Created by kim sunchul on 11/14/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import DI

public protocol SignupRepositoryType: AnyObject, Injectable {

  // MARK: - Method

  func signup(request: SignupRequest) async throws -> SignupInfo
}
