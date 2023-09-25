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

  // MARK: - Init

  public init() {
  }

  // MARK: - Method
  
  public func build() async -> LaunchWorkable {
    let rootWorker: LaunchWorkable = LaunchRootWorker()

    let delayTimerWorker: LaunchDelayWorker = .init(delayTime: 0.5)
    await rootWorker.push(item: delayTimerWorker)

    let checkVersionWorker: LaunchWorkable = DIContainer.resolve(
      for: CheckVersionLaunchWorkerKey.self
    )
    await rootWorker.push(item: checkVersionWorker)

    return rootWorker
  }
}
