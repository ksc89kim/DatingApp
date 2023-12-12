//
//  PaginationType.swift
//  Core
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public protocol PaginationType {

  // MARK: - Property

  var dataSource: PaginationDataSource? { get set }

  var state: PaginationState { get set }

  // MARK: - Method

  func load() async throws -> (any PaginationResponse)?

  func loadMoreIfNeeded(index: Int) async throws -> (any PaginationResponse)?

  func isAvailableLoadMore(index: Int) -> Bool
}
