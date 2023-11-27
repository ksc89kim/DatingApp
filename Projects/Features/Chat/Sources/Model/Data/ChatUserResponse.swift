//
//  ChatUserResponse.swift
//  ChatInterface
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import ChatInterface

struct ChatUserResponse: Codable {

  // MARK: - Property

  let nickname: String

  let userIdx: String

  let thumbnail: URL?

  // MARK: - Method

  func toEntity() -> ChatUserEntity {
    return .init(
      userIdx: self.userIdx,
      nickname: self.nickname,
      thumbnail: self.thumbnail
    )
  }
}
