//
//  MockLaunchWorkerBuilder.swift
//  LaunchTesting
//
//  Created by kim sunchul on 2023/09/12.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import LaunchInterface

public struct MockLaunchWorkerBuilder: LaunchWorkerBuildable {

  // MARK: - Property

  private let completionSendable: LaunchCompletionSendable?

  private let isSleep: Bool

  // MARK: - Init

  public init(
    completionSendable: LaunchCompletionSendable? = nil,
    isSleep: Bool = false
  ) {
    self.completionSendable = completionSendable
    self.isSleep = isSleep
  }

  // MARK: - Method

  public func build() -> LaunchWorkable {
    let rootWorker: MockLaunchWorker = .init()
    rootWorker.completionSender = self.completionSendable

    Task {
      let childWorker: MockLaunchWorker = .init()
      childWorker.isSleep = self.isSleep
      await rootWorker.push(item: childWorker)
    }

    return rootWorker
  }
}
