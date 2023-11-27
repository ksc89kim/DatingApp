//
//  CheckVersionLaunchWorker.swift
//  Version
//
//  Created by kim sunchul on 2023/08/28.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import LaunchInterface
import VersionInterface
import DI

final class CheckVersionLaunchWorker: LaunchWorkable, Injectable {

  // MARK: - Property

  weak var parent: LaunchWorkable?

  var items: [LaunchWorkable] = []

  var state: LaunchWorkerState = .ready

  var sender: LaunchSendable?

  var completionSender: LaunchCompletionSender?

  @Inject(VersionRepositoryTypeKey.self)
  private var repository: VersionRepositoryType

  // MARK: - Method

  func work() async throws {
    let entity = try await self.repository.checkVersion()
    guard let entity = entity else {
      throw CheckVersionLaunchWorkError.emptyEntity
    }
    guard !entity.isForceUpdate else {
      throw CheckVersionLaunchWorkError.forceUpdate(entity)
    }
  }
}
