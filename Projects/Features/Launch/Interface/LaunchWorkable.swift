//
//  LaunchWorkable.swift
//  LaunchInterface
//
//  Created by kim sunchul on 2023/08/10.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public protocol LaunchWorkable: AnyObject {

  // MARK: - Property

  var items: [LaunchWorkable] { get set }

  var state: LaunchState { get set }

  var isComplete: Bool { get }

  var totalSize: Int { get }

  var sender: LaunchSendable? { get set }

  var completionSender: LaunchSendable? { get set }

  // MARK: - Method

  func push(item: LaunchWorkable)
  
  func run() async throws

  func work() async throws
}


public extension LaunchWorkable {

  var isComplete: Bool {
    let isCompelte = self.state == .complete
    guard !self.items.isEmpty else { return isCompelte }
    return self.items.reduce(isCompelte) { partialResult, item in
      return partialResult && item.isComplete
    }
  }

  var totalSize: Int {
    guard !self.items.isEmpty else { return 1 }
    return self.items.reduce(1) { partialResult, item in
      return partialResult + item.totalSize
    }
  }

  func push(item: LaunchWorkable) {
    self.items.append(item)
  }

  func run() async throws {
    try Task.checkCancellation()

    self.state = .running
    try await self.work()
    self.state = .complete
    let data: LaunchCompletionCount = .init(
      totalCount: 1,
      completedCount: 1
    )
    await self.completionSender?.send(data)

    try Task.checkCancellation()

    try await withThrowingTaskGroup(of: Void.self) { group in
      for item in self.items {
        group.addTask {
            try await item.run()
        }
      }
      
      while let _ = try await group.next() {
      }
    }
  }
}
