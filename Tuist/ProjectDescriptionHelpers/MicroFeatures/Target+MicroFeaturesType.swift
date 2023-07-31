//
//  Target+MicroFeaturesType.swift
//  MicroFeaturesPlugin
//
//  Created by kim sunchul on 2023/07/26.
//

import ProjectDescription

public extension Target {

  static func features(
    name: String,
    types: Set<MicroFeaturesType>,
    baseBuilder: Target.Builder? = nil
  ) -> [Self] {
    var targets: [Target] = []
    if types.contains(.interface) {
      targets.append(
        .feature(
          name: name,
          type: .interface,
          baseBuilder: baseBuilder
        )
      )
    }

    if types.contains(.source) {
      targets.append(
        .feature(
          name: name,
          type: .source,
          baseBuilder: baseBuilder
        )
      )
    }

    if types.contains(.testing) {
      targets.append(
        .feature(
          name: name,
          type: .testing,
          baseBuilder: baseBuilder
        )
      )
    }

    if types.contains(.tests) {
      targets.append(
        .feature(
          name: name,
          type: .tests,
          baseBuilder: baseBuilder
        )
      )
    }

    if types.contains(.examples) {
      targets.append(
        .feature(
          name: name,
          type: .examples,
          baseBuilder: baseBuilder
        )
      )
    }

    return targets
  }

  static func feature(
    name: String,
    type: MicroFeaturesType,
    baseBuilder: Target.Builder? = nil
  ) -> Self {
    let builder: Target.Builder = .init()
    if let baseBuilder = baseBuilder {
      builder.builder(baseBuilder)
    }
    builder
      .sources(type.sourceFileList)
      .name(type.name(name: name))

    switch type {
    case .source:
      builder.product(.framework)
        .featuresDependencies(
          .init(interface: builder.featuresDependencies.interfaceDependencies)
        )
    case .interface:
      builder.product(.framework)
        .featuresDependencies(
          .init(source: builder.featuresDependencies.sourceDependencies)
        )
    case .testing:
      builder.product(.framework)
        .featuresDependencies(
          .init(testing: builder.featuresDependencies.testingDependencies)
        )
    case .tests:
      builder.product(.unitTests)
        .featuresDependencies(
          .init(tests: builder.featuresDependencies.testsDependencies)
        )
    case .examples:
      builder.product(.app)
        .featuresDependencies(
          .init(tests: builder.featuresDependencies.examplesDependencies)
        )
    }
    return builder.build()
  }
}
