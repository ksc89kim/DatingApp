//
//  TargetDependency+MicroFeaturesType.swift
//  ProjectDescriptionHelpers
//
//  Created by kim sunchul on 2023/07/31.
//

import ProjectDescription

public extension TargetDependency {

  static func makeDependencies(
    name: String,
    types: Set<MicroFeaturesType>
  ) -> [Self] {
    var dependencies: [TargetDependency] = []
    if types.contains(.interface) {
      dependencies.append(.makeDependency(name: name, type: .interface))
    }

    if types.contains(.source) {
      dependencies.append(.makeDependency(name: name, type: .source))
    }

    if types.contains(.testing) {
      dependencies.append(.makeDependency(name: name, type: .testing))
    }

    if types.contains(.tests) {
      dependencies.append(.makeDependency(name: name, type: .tests))
    }

    if types.contains(.examples) {
      dependencies.append(.makeDependency(name: name, type: .examples))
    }

    return dependencies
  }

  static func makeDependency(
    name: String,
    type: MicroFeaturesType
  ) -> Self {
    return .project(
      target: type.name(name: name),
      path: .relativeToRoot("/Projects/Features/" + name)
    )
  }
}
