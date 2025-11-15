//
//  UserRegisterRequest.swift
//  UserInterface
//
//  Created by kim sunchul on 2/11/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation

public struct UserRegisterRequest {

  // MARK: - Property

  public var birthday: String = ""
  
  public var height: String = ""
  
  public var singleSelectParameters: [String: Any] = [:]

  public var multipleSelectParameters: [String: Any] = [:]
  
  public var imagesDatas: [Data] = []

  public var paramters: [String: Any] {
    var parameters: [String: Any] = [
      "height": self.height,
      "birthday": self.birthday
    ]
    
    parameters.merge(self.singleSelectParameters) { current, _ in
      current
    }
    
    parameters.merge(self.multipleSelectParameters) { current, _ in
      current
    }

    return parameters
  }

  // MARK: - Init

  public init() { }
}
