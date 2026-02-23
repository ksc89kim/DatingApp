//
//  ChatSocketManagerStub.swift
//  Chat
//
import Foundation
import ChatInterface

final class ChatSocketManagerStub: ChatSocketManagerType {

  // MARK: - Property

  private var eventStream: AsyncThrowingStream<ChatWebSocketEvent, Error>?
  private var eventContinuation: AsyncThrowingStream<ChatWebSocketEvent, Error>.Continuation?
  private var timer: Timer?

  // MARK: - Method

  func connect(url: URL) {
    self.eventStream = AsyncThrowingStream { [weak self] continuation in
      self?.eventContinuation = continuation
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
    let chatMessage: ChatMessage = .init(
      messageIdx: "\(UUID())",
      user: .init(userIdx: request.userIdx, nickname: "", thumbnail: nil),
      messageKind: .text(request.message),
      isSender: true,
      date: .now
    )
    self.eventContinuation?.yield(.message(chatMessage))
  }

  func events() -> AsyncThrowingStream<ChatWebSocketEvent, Error>? {
    return self.eventStream
  }

  // MARK: - Private

  @MainActor
  private func receiveMessages() {
    self.timer = Timer.scheduledTimer(
      withTimeInterval: 5.0,
      repeats: true
    ) { [weak self] _ in
      let chatMessage: ChatMessage = .init(
        messageIdx: "\(UUID())",
        user: .init(userIdx: "other", nickname: "", thumbnail: nil),
        messageKind: .text("테스트: \(UUID())"),
        isSender: false,
        date: .now
      )
      self?.eventContinuation?.yield(.message(chatMessage))
    }
  }
}
