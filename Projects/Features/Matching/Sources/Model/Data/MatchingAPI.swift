//
//  MatchingAPI.swift
//  Matching
//
//  Created by claude on 2/17/26.
//

import Foundation
import Core

enum MatchingAPI {
  case recommendations(page: Int)
  case like(userID: String)
  case skip(userID: String)
}


extension MatchingAPI: NetworkTargetType {

  var method: Core.NetworkMethod {
    switch self {
    case .recommendations: return .get
    case .like, .skip: return .post
    }
  }

  var baseURL: URL {
    return .init(string: API.EndPoint.baseURL + "/matching")!
  }

  var path: String {
    switch self {
    case .recommendations: return "/recommendations"
    case .like: return "/like"
    case .skip: return "/skip"
    }
  }

  var headers: [String: String]? {
    return API.baseHeaders
  }

  var parameters: [String: Any] {
    switch self {
    case .recommendations(let page):
      return ["page": page]
    case .like(let userID):
      return ["user_id": userID]
    case .skip(let userID):
      return ["user_id": userID]
    }
  }

  var task: Core.NetworkTask {
    switch self {
    case .recommendations:
      return .requestParameters(
        parameters: self.parameters,
        encoding: .url
      )
    case .like, .skip:
      return .requestParameters(
        parameters: self.parameters,
        encoding: .json
      )
    }
  }

  var sampleData: Data {
    switch self {
    case .recommendations: return self.recommendationsSampleData
    case .like: return self.likeSampleData
    case .skip: return self.skipSampleData
    }
  }

  // MARK: - Sample Data

  private var thumbnails: [String] {
    return (1...10).map { index -> String in
      return "https://randomuser.me/api/portraits/women/\(index).jpg"
    }
  }

  private var names: [String] {
    return [
      "지민", "수연", "하은", "서윤", "민서",
      "예린", "수빈", "유나", "채원", "소희"
    ]
  }

  private var jobs: [String] {
    return [
      "디자이너", "개발자", "마케터", "간호사", "교사",
      "영양사", "약사", "작가", "사진가", "요리사"
    ]
  }

  private var recommendationsSampleData: Data {
    var list = ""
    for i in 0..<self.thumbnails.count {
      let data = """
              {
                "user_id": "user_\(i + 1)",
                "nickname": "\(self.names[i])",
                "age": \(Int.random(in: 22...32)),
                "profile_images": ["\(self.thumbnails[i])"],
                "job": "\(self.jobs[i])",
                "introduce": "안녕하세요 \(self.names[i])입니다!"
              },

      """
      list += data
    }

    list.removeLast()
    list.removeLast()

    var result = """
          {
            "code": 201,
            "message": "",
            "data": {
              "recommendations": [

          """
    result += list
    result += """
            ],
            "has_more": true
          }
        }
      """
    return result.data(using: .utf16)!
  }

  private var likeSampleData: Data {
    let isMatched = Bool.random()
    return """
    {
      "code": 201,
      "message": "",
      "data": {
        "is_matched": \(isMatched),
        "matched_user_id": \(isMatched ? "\"matched_user\"" : "null")
      }
    }
    """.data(using: .utf16)!
  }

  private var skipSampleData: Data {
    return """
    {
      "code": 201,
      "message": "",
      "data": {
      }
    }
    """.data(using: .utf16)!
  }
}
