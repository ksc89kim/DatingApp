//
//  LaunchCompletionSender.swift
//  LaunchInterface
//
//  Created by kim sunchul on 2023/08/15.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

actor LaunchCompletionSender: LaunchSendable {

  // MARK: - Property
  
  var completion: Completion? = nil

  // MARK: - Method

  func send(_ data: LaunchSendDataType? = nil) {
    self.completion?(data)
  }
  
  func setCompletion(_ completion: @escaping Completion) {
    self.completion = completion
  }
}
