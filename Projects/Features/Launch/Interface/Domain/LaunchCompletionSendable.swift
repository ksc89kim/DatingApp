//
//  LaunchCompletionSendable.swift
//  LaunchInterface
//
//  Created by kim sunchul on 2023/08/20.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public protocol LaunchCompletionSendable: Actor {

  // MARK: - Define

  typealias Completion = @MainActor (LaunchSendDataType?) -> Void

  // MARK: - Method

  func send() async

  func setCompletion(_ completion: @escaping Completion)

  func setTotalCount(_ count: Int)

  func setCompletedCount(_ count: Int)

  func addCompletedCount()
}
