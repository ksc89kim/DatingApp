//
//  CheckVersionEntity.swift
//  VersionInterface
//
//  Created by kim sunchul on 2023/09/01.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public struct CheckVersion {

  // MARK: - Property

  public let isForceUpdate: Bool

  public let message: String

  public let linkURL: URL?

  // MARK: - Init

  public init(isForceUpdate: Bool, message: String, linkURL: URL?) {
    self.isForceUpdate = isForceUpdate
    self.message = message
    self.linkURL = linkURL
  }
}
