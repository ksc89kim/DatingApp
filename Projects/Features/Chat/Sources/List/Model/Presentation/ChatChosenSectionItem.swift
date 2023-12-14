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

  var profile: ChatListProfile {
    return .init(thumbnail: self.thumbnail, badge: self.badge)
  }

  // MARK: - Init

  init(chosenUser: ChatChosenUser) {
    self.userIdx = chosenUser.user.userIdx
    self.nickname = chosenUser.user.nickname
    self.thumbnail = chosenUser.user.thumbnail
    self.badge = chosenUser.badge
  }
}


extension ChatChosenSectionItem {

  static func dummy(idx: String = "1") -> Self {
    return .init(
      chosenUser: .init(
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
