//
//  LaunchCompletionSender.swift
//  LaunchInterface
//
//  Created by kim sunchul on 2023/08/15.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

actor LaunchCompletionSender: LaunchCompletionSendable {

  // MARK: - Property
  
  var completion: Completion? = nil

  var counter: LaunchCompletionCounter = .init(totalCount: 1, completedCount: 0)

  // MARK: - Method

  func setTotalCount(_ count: Int) {
    self.counter.totalCount = count
  }

  func setCompletedCount(_ count: Int) {
    self.counter.completedCount = count
  }

  func addCompletedCount() {
    self.counter.completedCount += 1
  }

  func send() {
    self.addCompletedCount()
    self.completion?(self.counter)
  }
  
  func setCompletion(_ completion: @escaping Completion) {
    self.completion = completion
  }
}
