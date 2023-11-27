//
//  ChatAPI.swift
//  ChatInterface
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import Core

enum ChatAPI {
  case chatList
  case chosenList
}


extension ChatAPI: NetworkTargetType {

  var method: Core.NetworkMethod {
    return .get
  }

  var baseURL: URL {
    return .init(string: API.EndPoint.baseURL + "/chat")!
  }

  var path: String {
    switch self {
    case .chatList: return "/chat_list"
    case .chosenList: return "/chosen_list"
    }
  }

  var headers: [String: String]? {
    return API.baseHeaders
  }

  var parameters: [String: Any] {
    switch self {
    case .chatList: return [:]
    case .chosenList: return [:]
    }
  }

  var task: Core.NetworkTask {
    return .requestParameters(
      parameters: self.parameters,
      encoding: URLEncoding.default
    )
  }

  var sampleData: Data {
    switch self {
    case .chatList: return self.chatListSampleData
    case .chosenList: return self.chosenListSampleData
    }
  }

  private var chatListSampleData: Data {
    return """
    {
      "code": 201,
      "message": "",
      "data": {
      }
    }
    """.data(using: .utf16)!
  }

  private var chosenListSampleData: Data {
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
