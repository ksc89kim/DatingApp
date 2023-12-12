//
//  ChatListEntity.swift
//  ChatInterface
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import Core

public struct ChatListEntity: PaginationResponse {

  // MARK: - Property

  public var items: [ChatListMessageEntity]

  public let totalCount: Int

  public var isFinal: Bool

  // MARK: - Init
  
  public init(
    totalCount: Int,
    items: [ChatListMessageEntity],
    isFinal: Bool
  ) {
    self.totalCount = totalCount
    self.items = items
    self.isFinal = isFinal
  }
}
