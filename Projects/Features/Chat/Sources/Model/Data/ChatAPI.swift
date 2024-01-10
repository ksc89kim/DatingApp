//
//  ChatAPI.swift
//  Chat
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import Core

enum ChatAPI {
  case chatList(page: Int, limit: Int)
  case chosenList(page: Int, limit: Int)
  case deleteMessageRoom(roomIdx: String)
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
    case .deleteMessageRoom: return "/delete_message_room"
    }
  }

  var headers: [String: String]? {
    return API.baseHeaders
  }

  var parameters: [String: Any] {
    switch self {
    case .chatList(let page, let limit): 
      return [
        "page": page,
        "limit": limit
      ]
    case .chosenList(let page, let limit):
      return [
        "page": page,
        "limit": limit
      ]
    case .deleteMessageRoom(let roomIdx):
      return [
        "roomIdx": roomIdx
      ]
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
    case .deleteMessageRoom: return self.deleteSampleData
    }
  }

  private var thumbnails: [String] {
    return (1...60).map { index -> String in
      return "https://randomuser.me/api/portraits/women/\(index).jpg"
    }
  }

  private var names: [String] {
    return (1...60).map { index -> String in
      return "닉네임_\(index)"
    }
  }

  private var chatListSampleData: Data {
    var list = ""
    for i in 0 ..< self.thumbnails.count {
      let id = UUID()
      let data = """
              {
                "room_idx": "room.\(id)",
                "user": {
                  "user_idx": "user.\(id)",
                  "nickname": "\(self.names[i])",
                  "thumbnail": "\(self.thumbnails[i])"
                },
                "message": "당신과 이야기하고 싶어요~",
                "badge": false,
                "is_read": false
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
                "messages": [

            """
    result += list
    result += """
              ],
              "total_count": 100,
              "is_final": false
            }
          }
        """
    return result.data(using: .utf16)!
  }

  private var chosenListSampleData: Data {
    var list = ""
    for i in 0 ..< self.thumbnails.count {
      let id = UUID()
      let data = """
              {
                "user": {
                  "user_idx": "user.\(id)",
                  "nickname": "\(self.names[i])",
                  "thumbnail": "\(self.thumbnails[i])"
                },
                "badge": false,
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
                "users": [

            """
    result += list
    result += """
              ],
              "is_final": false
            }
          }
        """
    return result.data(using: .utf16)!
  }

  private var deleteSampleData: Data {
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
