//
//  UserAPI.swift
//  UserInterface
//
//  Created by kim sunchul on 10/6/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import Core

public enum UserAPI {
  case login
  case signup([String: Any])
}


extension UserAPI: NetworkTargetType {

  public var method: Core.NetworkMethod {
    return .get
  }

  public var baseURL: URL {
    return .init(string: API.EndPoint.baseURL + "/user")!
  }

  public var path: String {
    switch self {
    case .login: return "/login"
    case .signup: return "/signup"
    }
  }

  public var headers: [String: String]? {
    return API.baseHeaders
  }

  public var parameters: [String: Any] {
    switch self {
    case .login: return [:]
    case .signup(let parameter): return parameter
    }
  }

  public var task: Core.NetworkTask {
    return .requestParameters(
      parameters: self.parameters,
      encoding: URLEncoding.default
    )
  }

  public var sampleData: Data {
    switch self {
    case .login: return self.loginSampleData
    case .signup: return self.signupSampleData
    }
  }

  private var loginSampleData: Data {
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

  private var signupSampleData: Data {
    return """
    {
      "code": 201,
      "message": "",
      "data": {}
    }
    """.data(using: .utf16)!
  }
}
