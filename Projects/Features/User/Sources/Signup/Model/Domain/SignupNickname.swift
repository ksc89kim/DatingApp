//
//  SignupNickname.swift
//  User
//
//  Created by kim sunchul on 11/12/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import UserInterface

public final class SignupNickname: SignupMain {  

  // MARK: - Property

  var nickname: String

  var limitCount: Int

  public var isBottomDisable: Bool

  // MARK: - Init
  
  public init(
    nickname: String = "",
    limitCount: Int = 10
  ) {
    self.nickname = nickname
    self.isBottomDisable = nickname.isEmpty
    self.limitCount = limitCount
  }

  // MARK: - Method

  func updateNickname(nickname: String) {
    self.nickname = nickname
    self.isBottomDisable = nickname.isEmpty
  }

  public func mergeRequest(_ request: SignupRequest) -> SignupRequest {
    var request = request
    request.nickname = self.nickname
    return request
  }

  public func complete() { }
}
