//
//  TargetDependency+MicroFeaturesType.swift
//  ProjectDescriptionHelpers
//
//  Created by kim sunchul on 2023/07/31.
//

import ProjectDescription

public extension TargetDependency {

  static func features(
    name: String,
    types: Set<MicroFeaturesType>
  ) -> [Self] {
    var dependencies: [TargetDependency] = []
    if types.contains(.interface) {
      dependencies.append(.feature(name: name, type: .interface))
    }

    if types.contains(.source) {
      dependencies.append(.feature(name: name, type: .source))
    }

    if types.contains(.testing) {
      dependencies.append(.feature(name: name, type: .testing))
    }

    if types.contains(.tests) {
      dependencies.append(.feature(name: name, type: .tests))
    }

    if types.contains(.examples) {
      dependencies.append(.feature(name: name, type: .examples))
    }

    return dependencies
  }

  static func feature(
    name: String,
    type: MicroFeaturesType
  ) -> Self {
    return .project(
      target: type.name(name: name),
      path: .relativeToRoot("/Projects/Features/" + name)
    )
  }
}
