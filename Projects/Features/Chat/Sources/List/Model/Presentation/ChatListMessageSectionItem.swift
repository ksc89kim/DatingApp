//
//  ChatListMessageSectionItem.swift
//  Chat
//
//  Created by kim sunchul on 12/5/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import ChatInterface

struct ChatListMessageSectionItem {

  // MARK: - Property

  let roomIdx: String

  let nickname: String

  let thumbnail: URL?

  let message: String

  let badge: Bool

  let isRead: Bool

  // MARK: - Init

  init(entity: ChatListMessageEntity) {
    self.roomIdx = entity.roomIdx
    self.nickname = entity.user.nickname
    self.thumbnail = entity.user.thumbnail
    self.message = entity.message
    self.badge = entity.badge
    self.isRead = entity.isRead
  }

  // MARK: - Method

  func toProfile() -> ChatListProfile {
    return .init(thumbnail: self.thumbnail, badge: self.badge)
  }
}


extension ChatListMessageSectionItem {

  static func dummy(idx: String = "1") -> Self {
    return .init(
      entity: .init(
        roomIdx: idx,
        user: .init(
          userIdx: idx,
          nickname: "테스트",
          thumbnail: nil
        ),
        message: "안녕하세요",
        badge: false,
        isRead: true
      )
    )
  }
}
