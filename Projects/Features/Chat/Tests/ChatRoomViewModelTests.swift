//
//  ChatRoomViewModelTests.swift
//  ChatTests
//
//  Created by kim sunchul on 1/28/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import XCTest
@testable import DI
@testable import Core
@testable import ChatInterface
@testable import Chat
@testable import ChatTesting
@testable import AppStateInterface

final class ChatRoomViewModelTests: XCTestCase {

  // MARK: - Property

  private var repository: MockChatRepository!
  
  private var socketManager: MockChatSocketManager!
  
  private var roomIdx: String = "test"

  // MARK: - Method

  override func setUp() {
    super.setUp()

    self.repository = .init()
    self.socketManager = .init()
    AppStateDIRegister.register()

    DIContainer.register { [weak self] in
      InjectItem(ChatRepositoryKey.self) {
        return self!.repository
      }
      InjectItem(ChatSocketManagerTypeKey.self) {
        return self!.socketManager
      }
     }
  }
  
  /// 채팅방 정보 요청
  func testLoadRoomInfo() async {
    let viewModel = ChatRoomViewModel(pagination: Pagination())
    
    await viewModel.trigger(.loadRoomInfo(roomIdx: self.roomIdx))
    
    XCTAssertFalse(viewModel.state.items.isEmpty)
    XCTAssertEqual(viewModel.state.roomIdx, self.roomIdx)
    XCTAssertNotNil(viewModel.state.partner)
    XCTAssertEqual(self.socketManager.state, .connected)
  }
    
  /// 채팅방 메시지  더보기 요청
  func testLoadMoreMessages() async {
    let pagination = Pagination()
    let viewModel = ChatRoomViewModel(pagination: pagination)
    
    await viewModel.trigger(
      .loadMoreMessages(index: pagination.state.itemsFromEndThreshold)
    )
    
    XCTAssertFalse(viewModel.state.items.isEmpty)
    XCTAssertEqual(pagination.state.page, 1)
  }
  
  /// 채팅방 메시지 과거 메시지가 더이상 없을 경우 테스트 (마지막 페이지 호출 이후 아이템이 더 호출 되는지 테스트)
  func testMessagePageOver() async {
    let pagination = Pagination()
    let threshold = pagination.state.itemsFromEndThreshold
    self.repository.isFianl = true
    let viewModel = ChatRoomViewModel(pagination: pagination)

    await viewModel.trigger(.loadMoreMessages(index: threshold))

    let loadedCount = pagination.state.itemsLoadedCount

    await viewModel.trigger(.loadMoreMessages(index: loadedCount + threshold))

    XCTAssertEqual(viewModel.state.items.count, pagination.state.limit)
  }
  
  /// 채팅방 메시지 보내기
  func testSendMessage() async {
    let pagination = Pagination()
    let viewModel = ChatRoomViewModel(pagination: pagination)
    let sendMessage = "메시지 보냄"
    viewModel.state.newMessage = sendMessage
    
    await viewModel.trigger(.sendMessage)
    
    XCTAssertTrue(viewModel.state.newMessage.isEmpty)
    XCTAssertTrue(viewModel.state.scrollToBottm)
    XCTAssertEqual(self.socketManager.sendMessage, sendMessage)
  }
  
  /// 채팅방 메시지 받기
  func testReciveMessage() async throws {
    let pagination = Pagination()
    self.socketManager.reciveDelayTime = 0.05

    let viewModel = ChatRoomViewModel(pagination: pagination)
    await viewModel.trigger(.loadRoomInfo(roomIdx: self.roomIdx))
    
    XCTAssertEqual(viewModel.state.items.count, 30)
    XCTAssertEqual(self.socketManager.state, .connected)
    try await Task.sleep(nanoseconds: (self.socketManager.reciveDelayTime + 0.01).nanoseconds)
    
    XCTAssertEqual(viewModel.state.items.count, 31)
  }
  
  /// 채팅방 소켓 연결 실패
  func testSocketConnectError() async throws {
    let pagination = Pagination()
    self.socketManager.reciveDelayTime = 0.05
    self.socketManager.connectError = URLError(.unsupportedURL)
    let viewModel = ChatRoomViewModel(pagination: pagination)

    await viewModel.trigger(.loadRoomInfo(roomIdx: self.roomIdx))
    try await Task.sleep(nanoseconds: self.socketManager.reciveDelayTime.nanoseconds)
    viewModel.state.alert.primaryAction.completion?()
    
    XCTAssertTrue(viewModel.state.isPresentAlert)
    XCTAssertEqual(self.socketManager.state, .disconnected)
  }
  
  /// 기본 에러 처리
  func testDefaultErrorAlert() async {
    let pagination = Pagination()
    self.repository.error = MockChatRepository.NetworkError.default
    let viewModel = ChatRoomViewModel(pagination: pagination)

    await viewModel.trigger(.loadMoreMessages(index: pagination.state.itemsFromEndThreshold))
    
    XCTAssertTrue(viewModel.state.isPresentAlert)
    XCTAssertEqual(self.socketManager.state, .idle)
  }
}
