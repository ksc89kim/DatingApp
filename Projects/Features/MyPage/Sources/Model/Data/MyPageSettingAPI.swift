//
//  MyPageSettingAPI.swift
//  MyPage
//
//  Created by kim sunchul on 2/21/26.
//

import Foundation
import Core

enum MyPageSettingAPI {
  case logout
  case deleteAccount
}


extension MyPageSettingAPI: NetworkTargetType {

  var method: NetworkMethod {
    switch self {
    case .logout: return .post
    case .deleteAccount: return .delete
    }
  }

  var baseURL: URL {
    return .init(string: API.EndPoint.baseURL + "/user")!
  }

  var path: String {
    switch self {
    case .logout: return "/logout"
    case .deleteAccount: return "/me"
    }
  }

  var headers: [String: String]? {
    return API.baseHeaders
  }

  var parameters: [String: Any] {
    return [:]
  }

  var task: NetworkTask {
    return .requestParameters(parameters: [:], encoding: .url)
  }

  var sampleData: Data {
    return """
    {
      "code": 200,
      "message": "success",
      "data": {}
    }
    """.data(using: .utf16)!
  }
}
