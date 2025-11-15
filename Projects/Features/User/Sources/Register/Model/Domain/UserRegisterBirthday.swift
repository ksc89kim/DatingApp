//
//  UserRegisterBirthday.swift
//  User
//
//  Created by kim sunchul on 2/12/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation
import UserInterface

final class UserRegisterBirthday: UserRegisterMain {
  
  // MARK: - Property
  
  var birthday: Date
  
  var isBottomDisable: Bool = false
  
  weak var repository: UserRegisterRepositoryType?
  
  // MARK: - Init
  
  init(birthday: Date = .now) {
    self.birthday = birthday
  }
  
  // MARK: - Method
  
  func mergeRequest(_ request: UserRegisterRequest) -> UserRegisterRequest {
    var request = request
    let dateFormatter: DateFormatter = .init()
    dateFormatter.dateFormat = "yyyy-MM-DD"
    request.birthday = dateFormatter.string(from: self.birthday)
    return request
  }
  
  func updateBirthday(_ birthday: Date) {
    self.birthday = birthday
  }
}
