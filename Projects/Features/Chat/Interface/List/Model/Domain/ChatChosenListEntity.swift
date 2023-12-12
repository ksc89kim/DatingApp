//
//  ChatChosenEntity.swift
//  ChatInterface
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import Core

public struct ChatChosenListEntity: PaginationResponse {

  // MARK: - Property

  public var items: [ChatChosenUserEntity]

  public var isFinal: Bool

  // MARK: - Init

  public init(
    items: [ChatChosenUserEntity],
    isFinal: Bool
  ) {
    self.items = items
    self.isFinal = isFinal
  }
}
