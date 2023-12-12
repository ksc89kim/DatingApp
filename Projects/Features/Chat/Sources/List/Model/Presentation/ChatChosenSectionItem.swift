//
//  ChatChosenSectionItem.swift
//  Chat
//
//  Created by kim sunchul on 12/5/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import ChatInterface

struct ChatChosenSectionItem {

  // MARK: - Property

  let userIdx: String

  let nickname: String

  let thumbnail: URL?

  let badge: Bool

  // MARK: - Init

  init(entity: ChatChosenUserEntity) {
    self.userIdx = entity.user.userIdx
    self.nickname = entity.user.nickname
    self.thumbnail = entity.user.thumbnail
    self.badge = entity.badge
  }

  // MARK: - Method
  
  func toProfile() -> ChatListProfile {
    return .init(thumbnail: self.thumbnail, badge: self.badge)
  }
}


extension ChatChosenSectionItem {

  static func dummy(idx: String = "1") -> Self {
    return .init(
      entity: .init(
        user: .init(
          userIdx: idx,
          nickname: "테스트",
          thumbnail: nil
        ),
        badge: false
      )
    )
  }
}
