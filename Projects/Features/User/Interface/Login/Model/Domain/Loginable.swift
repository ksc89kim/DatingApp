//
//  Loginable.swift
//  UserInterface
//
//  Created by kim sunchul on 10/6/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import DI

public protocol Loginable: Injectable {

  // MARK: - Method

  func login() async throws
}
