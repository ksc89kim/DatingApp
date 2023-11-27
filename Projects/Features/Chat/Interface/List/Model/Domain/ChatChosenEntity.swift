//
//  ChatChosenEntity.swift
//  ChatInterface
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public struct ChatChosenEntity {

  // MARK: - Property

  public let users: [ChatChosenUserEntity]

  public let page: Int

  // MARK: - Init

  public init(
    users: [ChatChosenUserEntity],
    page: Int
  ) {
    self.users = users
    self.page = page
  }
}
