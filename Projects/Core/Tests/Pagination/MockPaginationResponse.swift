//
//  MockPaginationResponse.swift
//  Core
//
//  Created by kim sunchul on 11/28/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
@testable import Core

struct MockPaginationResponse: PaginationResponse {

  // MARK: - Property

  var items: [Int]

  var totalCount: Int

  var isFinal: Bool
}
