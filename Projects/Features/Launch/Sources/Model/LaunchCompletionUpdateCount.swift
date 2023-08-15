//
//  LaunchCompletionUpdateCount.swift
//  LaunchInterface
//
//  Created by kim sunchul on 2023/08/15.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

struct LaunchCompletionUpdateCount: LaunchCompletionSendData {

  // MARK: - Property

  let totalCount: Int

  let completedCount: Int
}
