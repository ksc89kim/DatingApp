//
//  LaunchWorkerBuilder.swift
//  LaunchInterface
//
//  Created by kim sunchul on 2023/09/12.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import DI
import LaunchInterface
import VersionInterface

struct LaunchWorkerBuilder: LaunchWorkerBuildable {

  func build() -> LaunchWorkable {
    let rootWorker: LaunchWorkable = DIContainer.resolve(for: CheckVersionLaunchWorkerKey.self)
    rootWorker.completionSender = LaunchCompletionSender()

    return rootWorker
  }
}
