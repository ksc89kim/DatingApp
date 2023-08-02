//
//  MicroFeaturesType+FilePaths.swift
//  MicroFeaturesPlugin
//
//  Created by kim sunchul on 2023/07/27.
//

import ProjectDescription

public extension MicroFeaturesType {

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
    case .source, .examples: return "Resources/**"
    case .interface, .testing, .tests: return nil
    }
  }
}
