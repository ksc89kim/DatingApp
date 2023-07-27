//
//  SourceFilesList+MicroFeatures.swift
//  MicroFeaturesPlugin
//
//  Created by kim sunchul on 2023/07/27.
//

import ProjectDescription

public extension SourceFilesList {

  static func path(type: MicroFeaturesType) -> Self {
    if type.contains(.interface) {
      return "Interface/**"
    } else if type.contains(.source) {
      return "Sources/**"
    } else if type.contains(.testing) {
      return "Testing/**"
    } else if type.contains(.tests) {
      return "Tests/**"
    } else if type.contains(.examples) {
      return "Examples/**"
    }
    return ""
  }
}
