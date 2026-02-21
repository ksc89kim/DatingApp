//
//  MyPageAPI.swift
//  MyPage
//
//  Created by kim sunchul on 2/19/26.
//

import Foundation
import Core

enum MyPageAPI {
  case me
  case updateMe(body: Data)
}


extension MyPageAPI: NetworkTargetType {

  var method: Core.NetworkMethod {
    switch self {
    case .me: return .get
    case .updateMe: return .put
    }
  }

  var baseURL: URL {
    return .init(string: API.EndPoint.baseURL + "/user")!
  }

  var path: String {
    return "/me"
  }

  var headers: [String: String]? {
    return API.baseHeaders
  }

  var parameters: [String: Any] {
    return [:]
  }

  var task: Core.NetworkTask {
    switch self {
    case .me:
      return .requestParameters(parameters: [:], encoding: .url)
    case .updateMe(let body):
      return .requestData(body)
    }
  }

  var sampleData: Data {
    switch self {
    case .me: return self.meSampleData
    case .updateMe: return self.meSampleData
    }
  }

  // MARK: - Sample Data

  private var meSampleData: Data {
    return """
    {
      "code": 201,
      "message": "",
      "data": {
        "user_id": "me_user_001",
        "nickname": "테스트유저",
        "profile_images": [
          "https://randomuser.me/api/portraits/women/1.jpg",
          "https://randomuser.me/api/portraits/women/2.jpg"
        ],
        "birthday": "1995-05-15",
        "height": "165",
        "job": "개발자",
        "game_genre": ["RPG", "FPS"],
        "introduce": "안녕하세요! 게임을 좋아하는 개발자입니다.",
        "mbti": "INFJ"
      }
    }
    """.data(using: .utf16)!
  }
}
