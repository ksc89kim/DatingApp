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

  var parent: LaunchWorkable? { get set }

  var items: [LaunchWorkable] { get set }

  var state: LaunchWorkerState { get set }

  var sender: LaunchSendable? { get set }

  var completionSender: LaunchCompletionSender? { get set }

  // MARK: - Method

  func push(item: LaunchWorkable) async
  
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

  var totalCount: Int {
    guard !self.items.isEmpty else { return 1 }
    return self.items.reduce(1) { partialResult, item in
      return partialResult + item.totalCount
    }
  }
  
  var root: LaunchWorkable {
    var rootWorkable: LaunchWorkable = self.parent ?? self
    while let parent = rootWorkable.parent {
      rootWorkable = parent
    }
    return rootWorkable
  }

  func push(item: LaunchWorkable) async {
    item.parent = self
    item.completionSender = self.completionSender
    self.items.append(item)
    await self.completionSender?.setTotalCount(self.root.totalCount)
  }

  func run() async throws {
    try Task.checkCancellation()
        
    switch self.state {
    case .ready, .running:
      self.state = .running
      try await self.work()
      self.state = .complete
      await self.completionSender?.send()
    case .complete: break
    }

    try Task.checkCancellation()
    
    guard !self.items.isEmpty else {
      return
    }

    try await withThrowingTaskGroup(of: Void.self) { group in
      for item in self.items {
        group.addTask {
            try await item.run()
        }
      }
      
      while try await group.next() != nil {}
    }
  }
}
