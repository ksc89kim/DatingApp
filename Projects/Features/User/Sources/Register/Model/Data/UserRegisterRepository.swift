//
//  UserRegisterRepository.swift
//  User
//
//  Created by kim sunchul on 2/12/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation
import UserInterface
import Core

final class UserRegisterRepository: UserRegisterRepositoryType {
  
  // MARK: - Property

  private let networking: Networking<UserAPI>

  // MARK: - Init

  init(networking: Networking<UserAPI>) {
    self.networking = networking
  }
  
  // MARK: - Method
  
  func register(request: UserRegisterRequest) async {
  
  }
}
