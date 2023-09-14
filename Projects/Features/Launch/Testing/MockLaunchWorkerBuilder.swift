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

  private let isSleep: Bool

  var error: Error?

  // MARK: - Init

  public init(
    isSleep: Bool = false,
    error: Error? = nil
  ) {
    self.isSleep = isSleep
    self.error = error
  }

  // MARK: - Method

  public func build() async -> LaunchWorkable {
    let rootWorker: MockLaunchWorker = .init()
    rootWorker.completionSender = LaunchCompletionSender()

    let childWorker: MockLaunchWorker = .init()
    childWorker.isSleep = self.isSleep
    childWorker.error = self.error
    await rootWorker.push(item: childWorker)

    return rootWorker
  }
}
