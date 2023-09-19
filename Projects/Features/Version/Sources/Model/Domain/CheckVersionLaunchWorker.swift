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

public final class CheckVersionLaunchWorker: LaunchWorkable, Injectable {

  // MARK: - Property

  public var parent: LaunchWorkable?

  public var items: [LaunchWorkable] = []

  public var state: LaunchState = .ready

  public var sender: LaunchSendable?

  public var completionSender: LaunchCompletionSender?

  private let repository: VersionRepositoryType

  // MARK: - Init

  public init(repository: VersionRepositoryType) {
    self.repository = repository
  }

  // MARK: - Method

  public func work() async throws {
    let entity = try await self.repository.checkVersion()
    guard let entity = entity else {
      throw CheckVersionLaunchWorkError.emptyEntity
    }
    guard !entity.isForceUpdate else {
      throw CheckVersionLaunchWorkError.forceUpdate(entity)
    }
  }
}
