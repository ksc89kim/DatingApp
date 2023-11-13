//
//  LaunchCompletionSender.swift
//  LaunchInterface
//
//  Created by kim sunchul on 2023/08/15.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public actor LaunchCompletionSender {

  // MARK: - Define

  public typealias Completion = @MainActor (LaunchCompletionCounter?) -> Void

  // MARK: - Property
  
  private(set) var completion: Completion?

  private(set) var counter: LaunchCompletionCounter
  
  // MARK: - Init

  public init(completion: Completion? = nil) {
    self.completion = completion
    self.counter = .init(totalCount: 1, completedCount: 0)
  }

  // MARK: - Method

  public func setTotalCount(_ count: Int) {
    self.counter.totalCount = count
  }

  func addTotalCount() {
    self.counter.totalCount += 1
  }

  public func setCompletedCount(_ count: Int) {
    self.counter.completedCount = count
  }

  func addCompletedCount() {
    self.counter.completedCount += 1
  }

  func send() async {
    self.addCompletedCount()
    await self.completion?(self.counter)
  }
  
  public func setCompletion(_ completion: @escaping Completion) {
    self.completion = completion
  }
}
