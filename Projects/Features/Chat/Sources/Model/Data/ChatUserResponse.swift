//
//  ChatUserResponse.swift
//  Chat
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import ChatInterface

struct ChatUserResponse: Codable {

  // MARK: - Define

  private enum Keys: String, CodingKey {
    case nickname
    case userIdx = "user_idx"
    case thumbnail
  }

  // MARK: - Property

  let nickname: String

  let userIdx: String

  let thumbnail: URL?

  var chatUser: ChatUser {
    return .init(
      userIdx: self.userIdx,
      nickname: self.nickname,
      thumbnail: self.thumbnail
    )
  }

  // MARK: - Init

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Keys.self)
    self.nickname = try container.decode(String.self, forKey: .nickname)
    self.userIdx = try container.decode(String.self, forKey: .userIdx)
    self.thumbnail = try container.decodeIfPresent(URL.self, forKey: .thumbnail)
  }
}
