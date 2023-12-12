//
//  PaginationResponse.swift
//  Core
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public protocol PaginationResponse {

  associatedtype Item

  // MARK: - Property

  var items: [Item] { get set }

  var isFinal: Bool { get set }
}


public extension PaginationResponse {

  var itemCount: Int { return self.items.count }
}
