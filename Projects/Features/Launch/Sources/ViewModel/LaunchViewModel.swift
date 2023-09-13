//
//  LaunchViewModel.swift
//  LaunchInterface
//
//  Created by kim sunchul on 2023/09/12.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import LaunchInterface

public final class LaunchViewModel: ObservableObject {

  // MARK: - Property

  private let rootWorkable: LaunchWorkable?

  @Published public var completionCount: String = ""

  // MARK: - Init
  
  public init(builder: LaunchWorkerBuildable?) {
    self.rootWorkable = builder?.build()
    self.bindWorkableCompletion()
  }

  // MARK: - Methods

  func run() {
    Task {
      do {
        await self.setCompletionCount(
          completedCount: 0,
          totalCount: self.rootWorkable?.totalCount ?? 0
        )
        try await self.rootWorkable?.run()
      } catch {
      }
    }
  }

  private func bindWorkableCompletion() {
    Task {
      await self.rootWorkable?.completionSender?.setCompletion { [weak self] data in
        guard let counter = data as? LaunchCompletionCounter else { return }
         self?.setCompletionCount(
          completedCount: counter.completedCount,
          totalCount: counter.totalCount
        )
      }
    }
  }

  @MainActor
  private func setCompletionCount(completedCount: Int, totalCount: Int) {
    guard totalCount > 0 else {
      self.completionCount = ""
      return
    }
    self.completionCount = "\(completedCount)/\(totalCount)"
  }
}
