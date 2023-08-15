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

  var data: LaunchCompletionSendData? = nil

  // MARK: - Method

  func send() {
    self.completion?(self.data)
  }

  func setData(_ data: LaunchCompletionSendData) {
    self.data = data
  }
  
  func setCompletion(_ completion: @escaping Completion) {
    self.completion = completion
  }
}
