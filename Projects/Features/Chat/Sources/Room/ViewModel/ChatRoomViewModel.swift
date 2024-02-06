//
//  ChatRoomViewModel.swift
//  Chat
//
//  Created by kim sunchul on 1/8/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation
import AppStateInterface
import ChatInterface
import Core
import DI
import Util

final class ChatRoomViewModel: ViewModelType, Injectable {
  
  // MARK: - Define
  
  private enum TaskKey {
    static let loadRoomInfo = "loadRoomInfo"
    static let loadMoreMessages = "loadMoreMessages"
    static let socketKey = "socketKey"
  }
  
  // MARK: - Property
  
  @Published
  public var state: ChatRoomState = .init()
  
  @Inject(AppStateKey.self)
  private var appState: AppState
  
  @Inject(ChatRepositoryKey.self)
  private var repository: ChatRepositoryType
  
  @Inject(ChatSocketManagerTypeKey.self)
  private var socketManager: ChatSocketManagerType
  
  private var pagination: PaginationType
  
  private var sectionProvider: ChatRoomSectionProvider
  
  private let taskBag: AnyCancelTaskDictionaryBag = .init()
  
  private let sendMessageTaskBag: AnyCancelTaskBag = .init()

  // MARK: - Init
  
  public init(
    pagination: PaginationType,
    provider: ChatRoomSectionProvider
  ) {
    self.pagination = pagination
    self.sectionProvider = provider
    self.pagination.dataSource = self
    self.sectionProvider.delegate = self
  }
  
  // MARK: - Trigger Method
  
  func trigger(_ action: ChatRoomAction) {
    switch action {
    case .loadRoomInfo(let roomIdx): self.loadRoomInfo(roomIdx: roomIdx)
    case .sendMessage: self.sendMessage()
    case .loadMoreMessages(let index): self.loadMoreMessages(index: index)
    case .back: self.back()
    }
  }
  
  public func trigger(_ action: ChatRoomAction) async {
    switch action {
    case .loadRoomInfo(let roomIdx): await self.loadRoomInfo(roomIdx: roomIdx)
    case .sendMessage: await self.sendMessage()
    case .loadMoreMessages(let index): await self.loadMoreMessages(index: index)
    case .back: break
    }
  }
  
  // MARK: - Load Room Info Method
  
  private func loadRoomInfo(roomIdx: String) {
    self.taskBag[TaskKey.loadRoomInfo]?.cancel()
    
    Task { [weak self] in
      await self?.loadRoomInfo(roomIdx: roomIdx)
    }
    .store(in: self.taskBag, for: TaskKey.loadRoomInfo)
  }
  
  private func loadRoomInfo(roomIdx: String) async {
    await MainActor.run {
      self.state.roomIdx = roomIdx
    }
    do {
      async let meta = try await self.repository.chatRoomMeta(
        roomIdx: roomIdx
      )
      async let messages = try await self.loadMessages()
      let (metaResult, messagesResult) = try await (meta, messages)
      try self.connectForSocket(url: metaResult.socketURL)
      await MainActor.run {
        self.state.partner = metaResult.partner
      }
      await self.sectionProvider.setItems(messagesResult)
    } catch {
      await self.handleError(error)
    }
  }
  
  private func connectForSocket(url: URL?) throws {
    guard let url = url else { throw URLError(.unsupportedURL) }
    self.socketManager.disconnect()
    self.taskBag[TaskKey.socketKey]?.cancel()
    self.socketManager.connect(url: url)
    
    Task.detached(priority: .background) { [weak self] in
      if let events = self?.socketManager.events() {
        for try await event in events {
          switch event {
          case .connected: break
          case .message(let message): await self?.sectionProvider.insertItem(message)
          case .error(let error): await self?.handleError(error)
          }
        }
      }
    }
    .store(in: self.taskBag, for: TaskKey.socketKey)
  }
  
  // MARK: - Load Messages Method
  
  private func loadMessages() async throws -> [ChatMessage] {
    let response = try await self.pagination.load()
    guard let messages = response?.items as? [ChatMessage] else { return [] }
    return messages
  }
  
  private func loadMoreMessages(index: Int) {
    guard self.pagination.isAvailableLoadMore(index: index),
            !self.state.items.isEmpty else { return }
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
        await self.sectionProvider.appendItems(messages)
      }
    } catch {
      await self.handleError(error)
    }
  }
  
  // MARK: - Send Message Method
  
  private func sendMessage() {
    Task { [weak self] in
      await self?.sendMessage()
    }
    .store(in: self.sendMessageTaskBag)
  }
  
  private func sendMessage() async {
    do {
      try await self.socketManager.sendMessage(
        request: .init(message: self.state.newMessage, userIdx: "me")
      )
      await MainActor.run {
        self.state.scrollToBottm = true
        self.state.newMessage = ""
      }
    } catch {
      await self.handleError(error)
    }
  }
  
  private func back() {
    self.appState.chatRouter.remove(path: .chatRoom(idx: self.state.roomIdx))
  }
  
  @MainActor
  private func handleError(_ error: Error) {
    if error is URLError {
      self.state.alert = .init(
        title: "",
        message: error.localizedDescription,
        primaryAction: .init(
          title: .confirm,
          type: .default,
          completion: { [weak self] in
            self?.back()
          }
        )
      )
    } else {
      self.state.alert = .message(error.localizedDescription)
    }
    self.state.isPresentAlert = true
  }
  
  deinit {
    self.socketManager.disconnect()
  }
}


// MARK: - PaginationDataSource

extension ChatRoomViewModel: PaginationDataSource {
  
  func load(request: PaginationRequest) async throws -> any PaginationResponse {
    let messageIdx = self.state.items.last?.message.id ?? "last_page"
    
    return try await self.repository.chatMessagese(
      request: .init(
        roomIdx: self.state.roomIdx,
        messageIdx: messageIdx,
        limit: request.limit
      )
    )
  }
}


// MARK: - ChatRoomSectionProviderDelegate

extension ChatRoomViewModel: ChatRoomSectionProviderDelegate {
  
  func items() -> [ChatMessageSectionItem] {
    return self.state.items
  }
  
  func setItems(items: [ChatMessageSectionItem]) {
    self.state.items = items
  }
}
