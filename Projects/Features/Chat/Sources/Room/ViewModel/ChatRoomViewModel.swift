//
//  ChatRoomViewModel.swift
//  Chat
//
//  Created by kim sunchul on 1/8/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation
import ChatInterface
import Core
import DI

final class ChatRoomViewModel: ViewModelType, Injectable {
  
  // MARK: - Define
  
  private enum TaskKey {
    static let loadMeta = "loadMeta"
    static let loadMoreMessages = "loadMoreMessages"
  }
  
  // MARK: - Property
  
  @Published
  public var state: ChatRoomState = .init()
  
  @Inject(ChatRepositoryKey.self)
  private var repository: ChatRepositoryType
  
  private let taskBag: AnyCancelTaskDictionaryBag = .init()
  
  private var pagination: PaginationType
  
  // MARK: - Init
  
  public init(pagination: PaginationType) {
    self.pagination = pagination
    self.pagination.dataSource = self
  }
  
  // MARK: - Method
  
  func trigger(_ action: ChatRoomAction) {
    switch action {
    case .loadMeta(let roomIdx): self.loadMeta(roomIdx: roomIdx)
    case .sendMessage: self.sendMessage()
    case .loadMoreMessages(let index): self.loadMoreMessages(index: index)
    }
  }
  
  public func trigger(_ action: ChatRoomAction) async {
    switch action {
    case .loadMeta(let roomIdx): await self.loadMeta(roomIdx: roomIdx)
    case .sendMessage: break
    case .loadMoreMessages(let index): await self.loadMoreMessages(index: index)
    }
  }
  
  private func loadMeta(roomIdx: String) {
    self.taskBag[TaskKey.loadMeta]?.cancel()
    
    Task { [weak self] in
      await self?.loadMeta(roomIdx: roomIdx)
    }
    .store(in: self.taskBag, for: TaskKey.loadMeta)
  }
  
  private func loadMeta(roomIdx: String) async {
    do {
      self.pagination.state.isLoading = true
      let meta = try await self.repository.chatRoomMeta(roomIdx: roomIdx)
      self.pagination.state.finished = meta.isFinal
      await self.setItems(messages: meta.messages)
      self.pagination.state.isLoading = false
    } catch {
      
    }
  }
  
  private func loadMoreMessages(index: Int) {
    guard self.pagination.isAvailableLoadMore(index: index) else { return }
    self.taskBag[TaskKey.loadMoreMessages]?.cancel()
    
    Task { [weak self] in
      await self?.loadMoreMessages(index: index)
    }
    .store(in: self.taskBag, for: TaskKey.loadMoreMessages)
  }
  
  private func loadMoreMessages(index: Int) async {
    do {
      let response = try await self.pagination.loadMoreIfNeeded(index: index)
      if let messages = response?.items as? [ChatMessage] {
        await self.appendItems(messages: messages)
      }
    } catch {
      
    }
  }
  
  private func sendMessage() {
    let chatMessage: ChatMessage = .init(
      messageIdx: "\(UUID())",
      user: .init(userIdx: "me", nickname: "", thumbnail: nil),
      messageKind: .text(self.state.newMessage),
      isSender: true,
      date: .now
    )
    
    self.state.items.insert(.init(message: chatMessage, index: 0), at: 0)
    self.state.items = self.state.items.enumerated().map { (
      offset: Int,
      item: ChatMessageSectionItem
    ) -> ChatMessageSectionItem in
      var item = item
      item.index = offset
      return item
    }
    self.state.scrollToBottm = true
    self.state.newMessage = ""
  }
  
  @MainActor
  private func setItems(messages: [ChatMessage]) {
    let items = messages.reversed().enumerated().map { offset, message in
      ChatMessageSectionItem(message: message, index: offset)
    }
    self.state.items = items
  }
  
  @MainActor
  private func appendItems(messages: [ChatMessage]) {
    let startIndex = self.state.items.count
    let items = messages.reversed().enumerated().map { offset, message in
      ChatMessageSectionItem(message: message, index: startIndex + offset)
    }
    self.state.items.append(contentsOf: items)
  }
  
  @MainActor
  private func scrollToBottom() {
    self.state.scrollToBottm = true
  }
}


// MARK: - PaginationDataSource

extension ChatRoomViewModel: PaginationDataSource {
  
  func load(request: PaginationRequest) async throws -> any PaginationResponse {
    let messageIdx = self.state.items.last?.message.id ?? ""
    return try await self.repository.chatMessagese(
      request: .init(messageIdx: messageIdx, limit: request.limit)
    )
  }
}
