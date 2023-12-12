//
//  ChatListMessagesPagiationDataSource.swift
//  Chat
//
//  Created by kim sunchul on 11/28/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import Core
import ChatInterface

final class ChatMessageListPagiationDataSource: PaginationDataSource {
  
  // MARK: - Property

  private let repository: ChatRepositoryType

  // MARK: - Init

  init(repository: ChatRepositoryType) {
    self.repository = repository
  }

  // MARK: - Method

  func load(
    request: PaginationRequest
  ) async throws -> any PaginationResponse {
    return try await self.repository.chatList(
      request: .init(page: request.page, limit: request.limit)
    )
  }
}
