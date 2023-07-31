//
//  MicroFeaturesType.swift
//  MicroFeaturesPlugin
//
//  Created by kim sunchul on 2023/07/26.
//

import Foundation

public enum MicroFeaturesType: String {
  case source
  case interface = "Interface"
  case testing = "Testing"
  case tests = "Tests"
  case examples = "Examples"
}


// MARK: - Set Extensions

public extension Set where Element == MicroFeaturesType {

  static let all: Set<MicroFeaturesType> = [
    .interface,
    .source,
    .testing,
    .tests,
    .examples
  ]
}
