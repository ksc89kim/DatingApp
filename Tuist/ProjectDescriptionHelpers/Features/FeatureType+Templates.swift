//
//  FeatureType+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by kim sunchul on 2023/07/27.
//

import ProjectDescription

public extension FeatureType {

  var sourceFileList: SourceFilesList {
    switch self {
    case .interface: return "Interface/**"
    case .examples: return "Examples/**"
    case .source: return "Sources/**"
    case .testing: return "Testing/**"
    case .tests: return "Tests/**"
    }
  }

  var resources: ResourceFileElements? {
    switch self {
    case .source: return "Resources/**"
    case .interface, .testing, .tests, .examples: return nil
    }
  }
  
  var product: Product {
    switch self {
    case .interface, .source: return Environment.forPreview.getBoolean(default: false) ? .framework : .staticFramework
    case .testing: return .staticFramework
    case .tests: return .unitTests
    case .examples: return .app
    }
  }
  
  func name(_ type: ProjectType.Features) -> String {
    if case .source = self {
      return type.rawValue
    }
    return type.rawValue + self.rawValue
  }
  
  func dependencyIfNeeded(_ features: ProjectType.Features) -> [TargetDependency] {
    switch self {
    case .interface: return [dependency(.base)]
    case .examples, .tests: return [
      feature(features, type: .source, in: true),
      feature(features, type: .testing, in: true)
    ]
    case .source, .testing: return [feature(features, type: .interface, in: true)]
    }
  }
}
