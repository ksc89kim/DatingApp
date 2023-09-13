//
//  LaunchCompletionSender.swift
//  LaunchInterface
//
//  Created by kim sunchul on 2023/08/15.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import LaunchInterface

public actor LaunchCompletionSender: LaunchCompletionSendable {

 // MARK: - Property
  
  var completion: Completion?

  var counter: LaunchCompletionCounter
  
  // MARK: - Init

  public init(completion: Completion? = nil) {
    self.completion = completion
    self.counter = .init(totalCount: 1, completedCount: 0)
  }

  // MARK: - Method

  public func setTotalCount(_ count: Int) {
    self.counter.totalCount = count
  }

  public func setCompletedCount(_ count: Int) {
    self.counter.completedCount = count
  }

  public func addCompletedCount() {
    self.counter.completedCount += 1
  }

  public func send() async {
    self.addCompletedCount()
    await self.completion?(self.counter)
  }
  
  public func setCompletion(_ completion: @escaping Completion) {
    self.completion = completion
  }
}
