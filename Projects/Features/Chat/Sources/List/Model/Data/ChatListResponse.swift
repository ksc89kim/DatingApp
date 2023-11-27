//
//  ChatListResponse.swift
//  ChatInterface
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import ChatInterface

struct ChatListResponse: Codable {

  // MARK: - Property

  let messages: [ChatListMessageResponse]

  let page: Int

  let count: Int

  // MARK: - Method

  func toEntity() -> ChatListEntity {
    let messages = self.messages.map { (
      response:  ChatListMessageResponse
    ) -> ChatListMessageEntity in
      return response.toEntity()
    }
    return .init(
      page: self.page,
      count: self.count,
      messages: messages
    )
  }
}
