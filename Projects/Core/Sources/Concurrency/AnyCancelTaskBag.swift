//
//  AnyCancelTaskBag.swift
//  Core
//
//  Created by kim sunchul on 2023/09/14.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public final class AnyCancelTaskBag {

  // MARK: - Property

  private var tasks: [any AnyCancellableTask] = []

  // MARK: - Init

  public init() {}

  // MARK: - Method

  public func push(task: any AnyCancellableTask) {
    self.tasks.append(task)
  }

  public func cancel() {
    self.tasks.forEach { $0.cancel() }
    self.tasks.removeAll()
  }

  // MARK: - Deinit

  deinit {
    self.cancel()
  }
}


extension Task {

  public func store(in bag: AnyCancelTaskBag) {
    bag.push(task: self)
  }
}
