//
//  AnyCancelTaskBagType.swift
//  Core
//
//  Created by kim sunchul on 2023/09/14.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public final class AnyCancelTaskDictionaryBag {

  // MARK: - Property

  private var tasks: [String: any AnyCancellableTask] = [:]

  // MARK: - Init

  public init() {}

  // MARK: - Method

  public func push(task: any AnyCancellableTask, for key: String) {
    self.tasks[key] = task
  }

  public func cancel() {
    self.tasks.forEach { $0.value.cancel() }
    self.tasks.removeAll()
  }

  public subscript(key: String) -> AnyCancellableTask? {
    return self.tasks[key]
  }

  // MARK: - Deinit

  deinit {
    self.cancel()
  }
}


extension Task {

  public func store(in bag: AnyCancelTaskDictionaryBag, for key: String) {
    bag.push(task: self, for: key)
  }
}
