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
    case .profile(let userID): return self.profileSampleData(for: userID)
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

  // MARK: - Private

  private func extractIndex(from userID: String) -> Int {
    if let last = userID.split(separator: ".").last,
       let index = Int(last) {
      return index
    }
    return abs(userID.hashValue) % 60 + 1
  }

  private func profileSampleData(for userID: String) -> Data {
    let index = self.extractIndex(from: userID)

    let jobs = [
      "개발자", "디자이너", "마케터", "교사", "간호사",
      "요리사", "변호사", "회계사", "작곡가", "사진작가",
      "약사", "건축가", "상담사", "번역가", "피트니스 트레이너"
    ]
    let mbtis = [
      "INTJ", "INTP", "ENTJ", "ENTP",
      "INFJ", "INFP", "ENFJ", "ENFP",
      "ISTJ", "ISFJ", "ESTJ", "ESFJ",
      "ISTP", "ISFP", "ESTP", "ESFP"
    ]
    let gameGenres = [
      "[\"RPG\", \"FPS\", \"어드벤처\"]",
      "[\"퍼즐\", \"시뮬레이션\"]",
      "[\"MOBA\", \"전략\", \"RPG\"]",
      "[\"리듬게임\", \"캐주얼\"]",
      "[\"FPS\", \"배틀로얄\", \"서바이벌\"]",
      "[\"어드벤처\", \"인디\", \"퍼즐\"]"
    ]
    let introduces = [
      "안녕하세요! 게임을 좋아하는 사람입니다. 같이 게임하면서 이야기 나눠요 :)",
      "맛집 탐방과 여행을 좋아합니다. 새로운 곳을 함께 탐험해요!",
      "운동과 독서를 즐기는 사람이에요. 건강한 라이프스타일을 추구합니다.",
      "음악 듣는 걸 좋아하고, 가끔 직접 연주도 해요. 취미가 비슷한 분 만나고 싶어요!",
      "카페 투어와 사진 찍기를 좋아해요. 일상 속 소소한 행복을 나누고 싶습니다.",
      "영화와 드라마 보는 걸 좋아해요. 같이 넷플릭스 볼 사람 구합니다!"
    ]

    let nickname = "닉네임_\(index)"
    let baseYear = 1990 + (index - 1) % 13
    let month = String(format: "%02d", (index % 12) + 1)
    let day = String(format: "%02d", (index % 28) + 1)
    let birthday = "\(baseYear)-\(month)-\(day)"
    let height = "\(155 + (index - 1) % 31)cm"
    let job = jobs[(index - 1) % jobs.count]
    let mbti = mbtis[(index - 1) % mbtis.count]
    let genre = gameGenres[(index - 1) % gameGenres.count]
    let introduce = introduces[(index - 1) % introduces.count]

    let subImage1 = (index % 60) + 1
    let subImage2 = ((index + 1) % 60) + 1

    return """
    {
      "code": 200,
      "message": "",
      "data": {
        "user_id": "\(userID)",
        "nickname": "\(nickname)",
        "profile_images": [
          "https://randomuser.me/api/portraits/women/\(index).jpg",
          "https://randomuser.me/api/portraits/women/\(subImage1).jpg",
          "https://randomuser.me/api/portraits/women/\(subImage2).jpg"
        ],
        "birthday": "\(birthday)",
        "height": "\(height)",
        "job": "\(job)",
        "game_genre": \(genre),
        "introduce": "\(introduce)",
        "mbti": "\(mbti)"
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
