//
//  CheckVersionResponse.swift
//  VersionInterface
//
//  Created by kim sunchul on 2023/08/28.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import VersionInterface

struct CheckVersionResponse: Codable {

  // MARK: - CodingKey

  private enum Keys: String, CodingKey {
    case isNeedUpdate = "is_need_update"
    case message
    case linkURL = "link_url"
  }

  // MARK: - Property
  
  private let isNeedUpdate: Bool

  private let message: String

  private let linkURL: URL?

  // MARK: - Init

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Keys.self)
    self.isNeedUpdate = try container.decode(Bool.self, forKey: .isNeedUpdate)
    self.message = try container.decode(String.self, forKey: .message)
    self.linkURL = try container.decodeIfPresent(URL.self, forKey: .linkURL)
  }

  // MARK: - Method

  func toEntity() -> CheckVersionEntity {
    return .init(
      isNeedUpdate: self.isNeedUpdate,
      message: self.message,
      linkURL: self.linkURL
    )
  }
}
