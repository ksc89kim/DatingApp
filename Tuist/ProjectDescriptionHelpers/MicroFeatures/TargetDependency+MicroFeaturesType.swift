//
//  TargetDependency+MicroFeaturesType.swift
//  ProjectDescriptionHelpers
//
//  Created by kim sunchul on 2023/07/31.
//

import ProjectDescription
import ProjectPathPlugin

public extension TargetDependency {

  static func features(
    target: ProjectPathType.Features,
    types: Set<MicroFeaturesType>
  ) -> [Self] {
    var dependencies: [TargetDependency] = []
    if types.contains(.interface) {
      dependencies.append(.feature(target: target, type: .interface))
    }

    if types.contains(.source) {
      dependencies.append(.feature(target: target, type: .source))
    }

    if types.contains(.testing) {
      dependencies.append(.feature(target: target, type: .testing))
    }

    if types.contains(.tests) {
      dependencies.append(.feature(target: target, type: .tests))
    }

    if types.contains(.examples) {
      dependencies.append(.feature(target: target, type: .examples))
    }

    return dependencies
  }

  static func feature(
    target: ProjectPathType.Features,
    type: MicroFeaturesType
  ) -> Self {
    return .project(
      target: type.name(target),
      path: .relativeToPathType(.features(target))
    )
  }
}
