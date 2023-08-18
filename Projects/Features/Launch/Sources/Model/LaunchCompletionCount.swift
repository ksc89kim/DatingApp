//
//  LaunchCompletionCount.swift
//  LaunchInterface
//
//  Created by kim sunchul on 2023/08/15.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

struct LaunchCompletionCount: LaunchSendDataType, Equatable {

  // MARK: - Property

  let totalCount: Int

  let completedCount: Int
}
