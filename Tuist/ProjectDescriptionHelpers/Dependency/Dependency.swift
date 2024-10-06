//
//  Dependency.swift
//  Manifests
//
//  Created by kim sunchul on 9/22/24.
//

import ProjectDescription

public func dependency(
  type: FeatureType,
  @ConfigurationBuilder<TargetDependency> _ content: () -> [TargetDependency]
) -> FeatureDependency {
  return .init(type: type, dependecies: content())
}

public func dependency(_ project: ProjectType) -> TargetDependency {
  return .project(target: project.name, path: .relativeToRoot(project.path))
}

public func feature(
  _ features: ProjectType.Features,
  type: FeatureType,
  in target: Bool = false
) -> TargetDependency {
  let name = type.name(features)
  if target {
    return .target(name: name)
  }
  let path = ProjectType.features(features).path
  return .project(target: name, path: .relativeToRoot(path))
}

public func dependency(
  _ project: ProjectType,
  type: FeatureType
) -> TargetDependency {
  let name = project.name + type.rawValue
  return .project(target: name, path: .relativeToRoot(project.path))
}
