//
//  MockChatSocketManager.swift
//  ChatTesting
//
//  Created by kim sunchul on 1/21/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation
import ChatInterface

final class MockChatSocketManager: ChatSocketManagerType {
  
  // MARK: - Property
  
  private var eventStream: AsyncThrowingStream<ChatWebSocketEvent, Error>?
  
  private var eventContinuation: AsyncThrowingStream<ChatWebSocketEvent, Error>.Continuation?
  
  private var timer: Timer?
  
  var sendMessage: String?
  
  // MARK: - Method
  
  func connect(url: URL) {
    self.eventStream = AsyncThrowingStream { continuation in
      self.eventContinuation = continuation
      Task { [weak self] in
        await self?.receiveMessages()
      }
    }
  }
  
  func disconnect() { 
    self.eventContinuation?.finish()
    self.eventStream = nil
    self.timer?.invalidate()
    self.timer = nil
  }
  
  func sendMessage(request: ChatMessageRequest) async throws {
    self.sendMessage = request.message
    let chatMessage: ChatMessage = .init(
      messageIdx: "\(UUID())",
      user: .init(userIdx: request.userIdx, nickname: "", thumbnail: nil),
      messageKind: .text(request.message),
      isSender: true,
      date: .now
    )
    self.eventContinuation?.yield(.message(chatMessage))
  }
  
  @MainActor
  private func receiveMessages() {
    self.timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
      let idx =  "\(UUID())"
      let chatMessage: ChatMessage = .init(
        messageIdx: "\(UUID())",
        user: .init(userIdx: "other", nickname: "", thumbnail: nil),
        messageKind: .text("테스트: " + idx),
        isSender: false,
        date: .now
      )
      self.eventContinuation?.yield(.message(chatMessage))
    }
  }
  
  func events() -> AsyncThrowingStream<ChatWebSocketEvent, Error>? {
    return self.eventStream
  }
}
