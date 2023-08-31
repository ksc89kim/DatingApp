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

public final class CheckVersionLaunchWorker: LaunchWorkable {

  // MARK: - Property

  public var parent: LaunchWorkable?

  public var items: [LaunchWorkable] = []

  public var state: LaunchState = .ready

  public var sender: LaunchSendable?

  public var completionSender: LaunchCompletionSendable?

  private let repository: VersionRepositoryType

  // MARK: - Init

  public init(repository: VersionRepositoryType) {
    self.repository = repository
  }

  // MARK: - Method

  public func work() async throws {
    let entity = try await self.repository.checkVersion()
    guard !entity.isNeedUpdate else {
      throw CheckVersionLaunchWorkError.needUpdate(entity)
    }
  }
}
