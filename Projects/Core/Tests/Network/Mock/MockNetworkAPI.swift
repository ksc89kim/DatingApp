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
  case test
  case parseError
  case empty
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
    return .init(string: API.EndPoint.baseURL)!
  }

  var path: String {
    return "/posts"
  }

  var headers: [String: String]? {
    return API.baseHeaders
  }

  var sampleData: Data {
    switch self {
    case .test: return self.testSampleData
    case .parseError: return self.parseErrorSampleData
    case .empty: return self.emptySampleData
    }
  }

  private var testSampleData: Data {
    return """
    {
      "code": 201,
      "message": "테스트",
      "data": {
          "isNeedUpdate": true
      }
    }
    """.data(using: .utf8)!
  }

  private var parseErrorSampleData: Data {
    return """
    {
      "code": 404,
      "message": "파싱 에러 데이터"
    }
    """.data(using: .utf8)!
  }

  private var emptySampleData: Data {
    return """
    {
      "code": 201,
      "message": "빈 데이터 테스트",
      "data": {
      }
    }
    """.data(using: .utf8)!
  }
}
