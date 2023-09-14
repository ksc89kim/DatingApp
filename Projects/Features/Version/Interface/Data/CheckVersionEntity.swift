//
//  CheckVersionEntity.swift
//  VersionInterface
//
//  Created by kim sunchul on 2023/09/01.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public struct CheckVersionEntity {

  // MARK: - Property

  public let isNeedUpdate: Bool

  public let message: String

  public let linkURL: URL

  // MARK: - Init

  public init(isNeedUpdate: Bool, message: String, linkURL: URL) {
    self.isNeedUpdate = isNeedUpdate
    self.message = message
    self.linkURL = linkURL
  }
}
