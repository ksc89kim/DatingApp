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
  case profile(String)
  case like(String)
  case skip(String)
  case report(String)
  case block(String)
}


extension UserAPI: NetworkTargetType {
  

  var method: Core.NetworkMethod {
    switch self {
    case .login, .profile: return .get
    case .signup, .like, .skip, .report, .block: return .post
    }
  }

  var baseURL: URL {
    return .init(string: API.EndPoint.baseURL + "/user")!
  }

  var path: String {
    switch self {
    case .login: return "/login"
    case .signup: return "/signup"
    case .profile(let userID): return "/profile/\(userID)"
    case .like(let userID): return "/profile/\(userID)/like"
    case .skip(let userID): return "/profile/\(userID)/skip"
    case .report(let userID): return "/profile/\(userID)/report"
    case .block(let userID): return "/profile/\(userID)/block"
    }
  }

  var headers: [String: String]? {
    return API.baseHeaders
  }

  var parameters: [String: Any] {
    switch self {
    case .login, .profile, .like, .skip, .report, .block: return [:]
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
    case .profile: return self.profileSampleData
    case .like, .skip, .report, .block: return self.emptySuccessSampleData
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

  var profileSampleData: Data {
    return """
    {
      "code": 200,
      "message": "",
      "data": {
        "user_id": "user_001",
        "nickname": "테스트유저",
        "profile_images": [
          "https://randomuser.me/api/portraits/women/1.jpg",
          "https://randomuser.me/api/portraits/women/2.jpg"
        ],
        "birthday": "1995-03-15",
        "height": "165cm",
        "job": "개발자",
        "game_genre": ["RPG", "FPS", "어드벤처"],
        "introduce": "안녕하세요! 게임을 좋아하는 개발자입니다. 같이 게임하면서 이야기 나눠요 :)",
        "mbti": "INTJ"
      }
    }
    """.data(using: .utf16)!
  }

  var emptySuccessSampleData: Data {
    return """
    {
      "code": 200,
      "message": "",
      "data": {}
    }
    """.data(using: .utf16)!
  }
}
