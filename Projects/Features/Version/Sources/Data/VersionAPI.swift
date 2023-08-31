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

  public var method: Core.Method {
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

  public var task: Core.Task {
    return .requestParameters(
      parameters: [:],
      encoding: URLEncoding.default
    )
  }
}
