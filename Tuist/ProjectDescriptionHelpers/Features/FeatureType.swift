//
//  FeatureType.swift
//  ProjectDescriptionHelpers
//
//  Created by kim sunchul on 2023/07/26.
//

import Foundation

public enum FeatureType: String {
  case source
  case interface = "Interface"
  case testing = "Testing"
  case tests = "Tests"
  case examples = "Examples"
  
  func bundleId(name: String) -> String {
    switch self {
    case .source: return .sources(name: name)
    case .interface: return .interface(name: name)
    case .testing: return .testing(name: name)
    case .tests: return .tests(name: name)
    case .examples: return .examples(name: name)
    }
  }
}


// MARK: - Set Extensions

public extension Set where Element == FeatureType {
  
    nonisolated(unsafe) static let all: Set<FeatureType> = [
    .interface,
    .source,
    .testing,
    .tests,
    .examples
  ]
}
