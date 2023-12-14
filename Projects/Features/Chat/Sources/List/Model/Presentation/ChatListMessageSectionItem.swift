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

  var profile: ChatListProfile {
    return .init(thumbnail: self.thumbnail, badge: self.badge)
  }

  // MARK: - Init

  init(chatListMessage: ChatListMessage) {
    self.roomIdx = chatListMessage.roomIdx
    self.nickname = chatListMessage.user.nickname
    self.thumbnail = chatListMessage.user.thumbnail
    self.message = chatListMessage.message
    self.badge = chatListMessage.badge
    self.isRead = chatListMessage.isRead
  }
}


extension ChatListMessageSectionItem {

  static func dummy(idx: String = "1") -> Self {
    return .init(
      chatListMessage: .init(
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
