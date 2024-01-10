//
//  ChatListViewModel.swift
//  Chat
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import Core
import DI
import ChatInterface
import AppStateInterface

final class ChatListViewModel: ViewModelType, Injectable {

  // MARK: - Define

  private enum TaskKey {
    static let load = "loadKey"
    static let loadMessageListMore = "loadMessageListMoreKey"
    static let loadChosenListMore = "loadChosenListMoreKey"
    static let deleteMessageRoom = "deleteMessageRoomKey"
  }

  // MARK: - Property

  @Published
  var state: ChatListState = .init()

  @Inject(ChatRepositoryKey.self)
  private var chatRepository: ChatRepositoryType

  @Inject(AppStateKey.self)
  private var appState: AppState

  private var listMessagePagination: PaginationType

  private var messagePagiationDataSource: ChatMessageListPagiationDataSource?

  private var chosenPagination: PaginationType

  private var chosenPaginationDataSource: ChatChosenPaginationDataSource?

  private let taskBag: AnyCancelTaskDictionaryBag = .init()

  // MARK: - Init

  init(
    listPagination: PaginationType,
    chosenPagination: PaginationType
  ) {
    defer {
      self.setDataSource()
    }
    self.listMessagePagination = listPagination
    self.chosenPagination = chosenPagination
  }

  func setDataSource() {
    self.messagePagiationDataSource = .init(repository: self.chatRepository)
    self.listMessagePagination.dataSource = self.messagePagiationDataSource
    self.chosenPaginationDataSource = .init(repository: self.chatRepository)
    self.chosenPagination.dataSource = self.chosenPaginationDataSource
  }

  // MARK: - Method (Trigger)

  func trigger(_ action: ChatListAction) {
    switch action {
    case .load: self.load()
    case .loadMessageListMore(index: let index):
      self.loadMoreIfNeeded(
        pagination: self.listMessagePagination,
        index: index,
        taskKey: TaskKey.loadMessageListMore
      )
    case .loadChosenListMore(index: let index):
      self.loadMoreIfNeeded(
        pagination: self.chosenPagination,
        index: index,
        taskKey: TaskKey.loadChosenListMore
      )
    case .deleteMessageRoom(roomIdx: let roomIdx):
      self.deleteMessageRoom(roomIdx: roomIdx)
    case .loadChosenList, .loadMessageList: break
    case .presentRoom(let roomIdx): self.presentRoom(roomIdx: roomIdx)
    }
  }

  func trigger(_ action: ChatListAction) async {
    switch action {
    case .loadMessageList: await self.loadMessageList()
    case .loadMessageListMore(let index): 
      await self.loadMoreIfNeeded(
        pagination: self.listMessagePagination,
        index: index
      )
    case .loadChosenList: await self.loadChosenList()
    case .loadChosenListMore(let index): 
      await self.loadMoreIfNeeded(
        pagination: self.chosenPagination,
        index: index
      )
    case .deleteMessageRoom(roomIdx: let roomIdx):
      await self.deleteMessageRoom(roomIdx: roomIdx)
    case .load: await self.load()
    case .presentRoom: break
    }
  }

  // MARK: - Method (Load)

  private func load() {
    self.taskBag[TaskKey.load]?.cancel()

    Task { [weak self] in
      await self?.load()
    }
    .store(in: self.taskBag, for: TaskKey.load)
  }

  private func load() async {
    await self.loadMessageList()
    await self.loadChosenList()
    await self.checkEmptyView()
  }

  // MARK: - Method (Load Message)

  private func loadMessageList() async {
    let entity: ChatList? = await self.load(pagination: self.listMessagePagination)
    guard let entity else { return }
    await self.setListTitle(entity.totalCount)
    await self.setMessages(entity.items.map(ChatListMessageSectionItem.init))
  }

  // MARK: - Method (Set Message)

  @MainActor
  private func setMessages(_ messages: [ChatListMessageSectionItem]) {
    self.state.messages = messages
  }

  @MainActor
  private func setListTitle(_ count: Int) {
    self.state.listTitle = "\(count)개의 대화방"
  }

  // MARK: - Method (Load Chosen)

  private func loadChosenList() async {
    let entity: ChatChosenList? = await self.load(pagination: self.chosenPagination)
    guard let entity else { return }
    await self.setChosenUsers(entity.items.map(ChatChosenSectionItem.init))
  }

  // MARK: - Method (Set Chosen)

  @MainActor
  private func setChosenUsers(_ users: [ChatChosenSectionItem]) {
    self.state.chosenUsers = users
  }

  // MARK: - Method (Delete Message)

  private func deleteMessageRoom(roomIdx: String) {
    self.taskBag[TaskKey.deleteMessageRoom]?.cancel()

    Task { [weak self] in
      await self?.deleteMessageRoom(roomIdx: roomIdx)
    }
    .store(in: self.taskBag, for: TaskKey.deleteMessageRoom)
  }

  private func deleteMessageRoom(roomIdx: String) async {
    do {
      try await self.chatRepository.deleteMessageRoom(roomIdx: roomIdx)
      await self.removeMessage(roomIdx: roomIdx)
    } catch {
      await self.handleError(error)
    }
  }

  @MainActor
  private func removeMessage(roomIdx: String) {
    self.state.messages.removeAll { (item: ChatListMessageSectionItem)  in
      return roomIdx == item.roomIdx
    }
  }

  // MARK: - Method (Handle Error)
  
  @MainActor
  private func handleError(_ error: Error) {
    self.state.alert = .message(error.localizedDescription)
    self.state.isPresentAlert = true
  }

  // MARK: - Method (Empty View)

  @MainActor
  private func checkEmptyView() {
    let isMessagesEmpty = self.state.messages.isEmpty
    let isChosenUsersEmpty = self.state.chosenUsers.isEmpty
    self.state.isEmpty = isMessagesEmpty && isChosenUsersEmpty
  }

  // MARK: - Method (Room)

  private func presentRoom(roomIdx: String) {
    self.appState.chatRouter.append(path: .chatRoom(idx: roomIdx))
  }

  // MARK: - Method (ETC)

  private func load<Entity, Pagination: PaginationType>(
    pagination: Pagination
  ) async -> Entity? {
    do {
      return try await pagination.load() as? Entity
    } catch {
      await self.handleError(error)
    }
    return nil
  }

  private func loadMoreIfNeeded(
    pagination: some PaginationType,
    index: Int,
    taskKey: String
  ) {
    guard self.isAvailableMore(
      pagination: pagination,
      index: index
    ) else { return }

    self.taskBag[taskKey]?.cancel()

    Task { [weak self] in
      await self?.loadMoreIfNeeded(
        pagination: pagination,
        index: index
      )
    }
    .store(in: self.taskBag, for: taskKey)
  }

  private func isAvailableMore(
    pagination: some PaginationType,
    index: Int
  ) -> Bool {
    return pagination.isAvailableLoadMore(index: index)
  }

  private func loadMoreIfNeeded(
    pagination: some PaginationType,
    index: Int
  ) async {
    do {
      let response = try await pagination.loadMoreIfNeeded(index: index)
      await self.updateItems(response)
    } catch {
      await self.handleError(error)
    }
  }

  private func updateItems(_ response: (any PaginationResponse)?) async {
    if let listEntity = response as? ChatList {
      let items = listEntity.items.map(ChatListMessageSectionItem.init)
      await self.setMessages(self.state.messages + items)
    } else if let chosenEntity = response as? ChatChosenList {
      let items = chosenEntity.items.map(ChatChosenSectionItem.init)
      await self.setChosenUsers(self.state.chosenUsers + items)
    }
  }
}
