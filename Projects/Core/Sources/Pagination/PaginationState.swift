//
//  PaginationState.swift
//  Core
//
//  Created by kim sunchul on 11/28/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public struct PaginationState {

  // MARK: - Property

  var page: Int

  var itemsLoadedCount: Int

  public var itemsFromEndThreshold: Int

  public var limit: Int

  public var finished: Bool = false

  public var isLoading: Bool = false

  // MARK: - Init

  init(
    page: Int = 0,
    itemsLoadedCount: Int = 0,
    itemsFromEndThreshold: Int = 15,
    limit: Int = 30,
    finished: Bool = false,
    isLoading: Bool = false,
    threshold: ((Self, Int) -> Bool)? = nil
  ) {
    self.page = page
    self.itemsLoadedCount = itemsLoadedCount
    self.limit = limit
    self.itemsFromEndThreshold = itemsFromEndThreshold
    self.finished = finished
    self.isLoading = isLoading
  }

  mutating func reset() {
    self.page = 0
    self.itemsLoadedCount = 0
    self.finished = false
  }

  mutating func nextPage() {
    self.page += 1
  }

  func isAvailableLoadMore(index: Int) -> Bool {
    return self.thresholdMeet(index: index) && !self.finished && !self.isLoading
  }

  private func thresholdMeet(index: Int) -> Bool {
    return (self.itemsLoadedCount - index) <= self.itemsFromEndThreshold
  }
}
