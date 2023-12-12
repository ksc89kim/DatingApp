//
//  MockPagiationDataSource.swift
//  Core
//
//  Created by kim sunchul on 11/28/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
@testable import Core

final class MockPagiationDataSource: PaginationDataSource {

  // MARK: - Property

  var isFinal: Bool = false

  var error: Error?

  // MARK: - Method

  func load(
    request: PaginationRequest
  ) async throws -> (any PaginationResponse) {
    if let error = self.error { throw error }
    let items = (1...request.limit).map { $0 }

    return MockPaginationResponse(
      items: items,
      totalCount: 0,
      isFinal: self.isFinal
    )
  }
}
