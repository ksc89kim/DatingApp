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
import UserInterface

public struct LaunchWorkerBuilder: LaunchWorkerBuildable {

  // MARK: - Method
  
  public func build() async -> LaunchWorkable {
    let rootWorker: LaunchWorkable = LaunchRootWorker()

    let delayTimerWorker: LaunchDelayWorker = .init(delayTime: 1.0)
    await rootWorker.push(item: delayTimerWorker)

    let checkVersionWorker: LaunchWorkable = DIContainer.resolve(
      for: CheckVersionLaunchWorkerKey.self
    )
    await rootWorker.push(item: checkVersionWorker)

    let loginWorker: LaunchWorkable = DIContainer.resolve(
      for: LoginLaunchWorkerKey.self
    )
    await checkVersionWorker.push(item: loginWorker)

    return rootWorker
  }
}
