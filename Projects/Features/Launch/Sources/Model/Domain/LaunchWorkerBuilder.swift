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

public struct LaunchWorkerBuilder: LaunchWorkerBuildable {

  public func build() async -> LaunchWorkable {
    let rootWorker: LaunchWorkable = LaunchRootWorker()
    rootWorker.completionSender = LaunchCompletionSender()

    let checkVersionWorker: LaunchWorkable = DIContainer.resolve(
      for: CheckVersionLaunchWorkerKey.self
    )
    await checkVersionWorker.push(item: checkVersionWorker)

    return rootWorker
  }
}
