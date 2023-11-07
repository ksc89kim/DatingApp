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
    }
  }

  public var headers: [String: String]? {
    return API.baseHeaders
  }

  public var task: Core.NetworkTask {
    return .requestParameters(
      parameters: [:],
      encoding: URLEncoding.default
    )
  }

  public var sampleData: Data {
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
