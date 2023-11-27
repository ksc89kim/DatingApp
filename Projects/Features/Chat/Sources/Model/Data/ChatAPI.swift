//
//  ChatAPI.swift
//  ChatInterface
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import Core

public enum ChatAPI {
  case chatList
  case chosenList
}


extension ChatAPI: NetworkTargetType {

  public var method: Core.NetworkMethod {
    return .get
  }

  public var baseURL: URL {
    return .init(string: API.EndPoint.baseURL + "/chat")!
  }

  public var path: String {
    switch self {
    case .chatList: return "/chat_list"
    case .chosenList: return "/chosen_list"
    }
  }

  public var headers: [String: String]? {
    return API.baseHeaders
  }

  public var parameters: [String: Any] {
    switch self {
    case .chatList: return [:]
    case .chosenList: return [:]
    }
  }

  public var task: Core.NetworkTask {
    return .requestParameters(
      parameters: self.parameters,
      encoding: URLEncoding.default
    )
  }

  public var sampleData: Data {
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
