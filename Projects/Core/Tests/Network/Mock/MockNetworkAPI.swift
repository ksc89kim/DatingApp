//
//  MockNetworkAPI.swift
//  Core
//
//  Created by kim sunchul on 2023/08/27.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import Core

enum MockNetorkAPI {
  case testAPI
}


extension MockNetorkAPI: NetworkTargetType {

  var method: Core.Method {
    return .post
  }

  var task: Core.Task {
    return .requestParameters(
      parameters: [:],
      encoding: URLEncoding.default
    )
  }

  var baseURL: URL {
    return .init(string: "https://jsonplaceholder.typicode.com")!
  }

  var path: String {
    return "/posts"
  }

  var headers: [String: String]? {
    return ["Accept": "application/json"]
  }

  var sampleData: Data {
    return """
    {
      code: 200
    }
    """.data(using: .utf8)!
  }
}
