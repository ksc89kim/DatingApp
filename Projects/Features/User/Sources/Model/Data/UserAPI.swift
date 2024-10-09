//
//  UserAPI.swift
//  UserInterface
//
//  Created by kim sunchul on 10/6/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import Core

enum UserAPI {
  case login
  case signup([String: Any])
}


extension UserAPI: NetworkTargetType {
  

  var method: Core.NetworkMethod {
    return .get
  }

  var baseURL: URL {
    return .init(string: API.EndPoint.baseURL + "/user")!
  }

  var path: String {
    switch self {
    case .login: return "/login"
    case .signup: return "/signup"
    }
  }

  var headers: [String: String]? {
    return API.baseHeaders
  }

  var parameters: [String: Any] {
    switch self {
    case .login: return [:]
    case .signup(let parameter): return parameter
    }
  }

  var task: Core.NetworkTask {
    return .requestParameters(
      parameters: self.parameters,
      encoding: .url
    )
  }

  var sampleData: Data {
    switch self {
    case .login: return self.loginSampleData
    case .signup: return self.signupSampleData
    }
  }

  var loginSampleData: Data {
    return """
    {
      "code": 201,
      "message": "",
      "data": {
        "token": "TEST_TOKEN"
      }
    }
    """.data(using: .utf16)!
  }

  var signupSampleData: Data {
    return """
    {
      "code": 201,
      "message": "",
      "data": {
        "token": "TEST_TOKEN"
      }
    }
    """.data(using: .utf16)!
  }
}
