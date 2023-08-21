//
//  LaunchCompletionCount.swift
//  LaunchInterface
//
//  Created by kim sunchul on 2023/08/15.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

struct LaunchCompletionCounter: LaunchSendDataType, Equatable {

  // MARK: - Property

  var totalCount: Int

  var completedCount: Int
}
