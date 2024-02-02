//
//  ChatSocketManager.swift
//  Chat
//
//  Created by kim sunchul on 1/18/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation
import ChatInterface

final class ChatSocketManager: NSObject, ChatSocketManagerType {
  
  // MARK: - Property
  
  private var urlSession: URLSession?
  
  private var webSocketTask: URLSessionWebSocketTask?
  
  private var eventStream: AsyncThrowingStream<ChatWebSocketEvent, Error>?
  
  private var eventContinuation: AsyncThrowingStream<ChatWebSocketEvent, Error>.Continuation?
  
  // MARK: - Method
  
  func connect(url: URL) {
    self.urlSession = URLSession(
      configuration: .default,
      delegate: self,
      delegateQueue: OperationQueue()
    )
    self.webSocketTask = self.urlSession?.webSocketTask(with: url)
    self.webSocketTask?.resume()
    
    self.eventStream = AsyncThrowingStream { [weak self] continuation in
      self?.eventContinuation = continuation
      Task { [weak self] in
        await self?.receiveMessages()
      }
    }
  }
  
  func disconnect() {
    self.webSocketTask?.cancel(with: .goingAway, reason: nil)
    self.eventContinuation?.finish()
    self.urlSession?.finishTasksAndInvalidate()
    self.eventStream = nil
    self.eventContinuation = nil
    self.urlSession = nil
    self.webSocketTask = nil
  }
  
  func sendMessage(request: ChatMessageRequest) async throws {
    let data = try JSONEncoder().encode(request)
    let message = URLSessionWebSocketTask.Message.data(data)
    try await self.webSocketTask?.send(message)
  }
  
  private func receiveMessages() async {
    while let task = self.webSocketTask {
      do {
        let result = try await task.receive()
        switch result {
        case .string(let text):
          if let data = text.data(using: .utf8) {
            try self.yieldMessage(data: data)
          }
        case .data(let data):
          try self.yieldMessage(data: data)
        @unknown default:
          break
        }
      } catch {
//        self.eventContinuation?.yield(.error(error))
        break
      }
    }
  }
  
  private func yieldMessage(data: Data) throws {
    let response = try JSONDecoder().decode(
      ChatMessageResponse.self,
      from: data
    )
    self.eventContinuation?.yield(.message(response.chatMessage))
  }
  
  func events() -> AsyncThrowingStream<ChatWebSocketEvent, Error>? {
    return self.eventStream
  }
}


// MARK: - URLSessionWebSocketDelegate

extension ChatSocketManager: URLSessionWebSocketDelegate {
  
  func urlSession(
    _ session: URLSession,
    webSocketTask: URLSessionWebSocketTask,
    didOpenWithProtocol protocol: String?
  ) {
    self.eventContinuation?.yield(.connected)
  }
}
