//
//  PaginationDataSource.swift
//  Core
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public protocol PaginationDataSource: AnyObject {

  // MARK: - Method
  
  func load(request: PaginationRequest) async throws -> any PaginationResponse
}
