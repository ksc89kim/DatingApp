//
//  ChatUserEntity.swift
//  ChatInterface
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public struct ChatUserEntity {

  // MARK: - Property

  public let userIdx: String

  public let nickname: String

  public let thumbnail: URL?

  // MARK: - Init

  public init(
    userIdx: String,
    nickname: String,
    thumbnail: URL?
  ) {
    self.userIdx = userIdx
    self.nickname = nickname
    self.thumbnail = thumbnail
  }
}
