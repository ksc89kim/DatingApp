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

  public init(rootWorkable: LaunchWorkable?) {
    self.rootWorkable = rootWorkable
    
    self.bindWorkableCompletion()
  }

  // MARK: - Methods

  func run() {
    Task {
      do {
        try await self.rootWorkable?.run()
      } catch {
      }
    }
  }

  private func bindWorkableCompletion() {
    Task {
      await self.rootWorkable?.completionSender?.setCompletion { [weak self] data in
        guard let counter = data as? LaunchCompletionCounter else { return }
        self?.completionCount = "\(counter.completedCount)/\(counter.totalCount)"
      }
    }
  }
}
