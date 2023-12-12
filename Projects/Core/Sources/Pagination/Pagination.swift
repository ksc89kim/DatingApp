//
//  Pagination.swift
//  Core
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public final class Pagination: PaginationType {

  // MARK: - Property

  public weak var dataSource: PaginationDataSource?

  public var state: PaginationState = .init()

  // MARK: - Init

  public init() { }

  // MARK: - Method

  public func load() async throws -> (any PaginationResponse)? {
    self.state.reset()
    return try await self.requestLoad(index: 0)
  }

  public func loadMoreIfNeeded(
    index: Int
  ) async throws -> (any PaginationResponse)? {
    guard self.isAvailableLoadMore(index: index) else { return nil }
    self.state.nextPage()
    return try await self.requestLoad(index: index)
  }

  public func isAvailableLoadMore(index: Int) -> Bool {
    return self.state.isAvailableLoadMore(
      index: index
    )
  }

  private func requestLoad(index: Int) async throws -> (any PaginationResponse)? {
    guard !self.state.isLoading else { return nil }
    self.state.isLoading = true
    let response = try await self.dataSource?.load(
      request: .init(
        page: self.state.page,
        index: index,
        limit: self.state.limit
      )
    )
    self.state.isLoading = false
    if let response {
      self.state.itemsLoadedCount += response.itemCount
      self.state.finished = response.isFinal
    }
    return response
  }
}
