//
//  LaunchCompletionSendable.swift
//  LaunchInterface
//
//  Created by kim sunchul on 2023/08/15.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

protocol LaunchCompletionSendable: Actor {

  // MARK: - Define

  typealias Completion = (LaunchCompletionSendData?) -> Void

  // MARK: - Method

  func send()

  func setData(_ data: LaunchCompletionSendData)

  func setCompletion(_ completion: @escaping Completion)
}
