//
//  ChatChosenList.swift
//  ChatInterface
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import Core

public struct ChatChosenList: PaginationResponse {

  // MARK: - Property

  public var items: [ChatChosenUser]

  public var isFinal: Bool

  // MARK: - Init

  public init(
    items: [ChatChosenUser],
    isFinal: Bool
  ) {
    self.items = items
    self.isFinal = isFinal
  }
}
