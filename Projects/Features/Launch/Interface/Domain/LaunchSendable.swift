//
//  LaunchCompletionSendable.swift
//  LaunchInterface
//
//  Created by kim sunchul on 2023/08/15.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public protocol LaunchSendable: Actor {

  // MARK: - Define

  typealias Completion = (LaunchSendDataType?) -> Void

  // MARK: - Method

  func send() async

  func setCompletion(_ completion: @escaping Completion)
}
