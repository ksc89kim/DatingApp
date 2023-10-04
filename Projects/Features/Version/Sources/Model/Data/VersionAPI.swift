//
//  VersionAPI.swift
//  Version
//
//  Created by kim sunchul on 2023/08/28.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Core
import Foundation

public enum VersionAPI {
  case checkVersion
}


extension VersionAPI: NetworkTargetType {

  public var method: Core.NetworkMethod {
    return .get
  }

  public var baseURL: URL {
    return .init(string: API.EndPoint.baseURL + "/version")!
  }

  public var path: String {
    switch self {
    case .checkVersion: return "/check"
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
        "is_force_update": false,
        "message": "",
        "link_url": null
      }
    }
    """.data(using: .utf16)!
  }
}
