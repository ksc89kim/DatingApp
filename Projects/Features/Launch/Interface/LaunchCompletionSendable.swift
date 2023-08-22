//
//  LaunchCompletionSendable.swift
//  LaunchInterface
//
//  Created by kim sunchul on 2023/08/20.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public protocol LaunchCompletionSendable: LaunchSendable {

  // MARK: - Method

  func setTotalCount(_ count: Int)

  func setCompletedCount(_ count: Int)

  func addCompletedCount()
}
