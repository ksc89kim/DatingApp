//
//  ChatListRequest.swift
//  ChatInterface
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public struct ChatListRequest {

  // MARK: - Property

  public let page: Int

  public let limit: Int

  // MARK: - Init

  public init(page: Int, limit: Int) {
    self.page = page
    self.limit = limit
  }
}
