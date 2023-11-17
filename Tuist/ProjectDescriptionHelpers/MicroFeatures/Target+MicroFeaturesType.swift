//
//  Target+MicroFeaturesType.swift
//  MicroFeaturesPlugin
//
//  Created by kim sunchul on 2023/07/26.
//

import ProjectDescription
import ProjectPathPlugin

public extension Target {

  static func features(
    target: ProjectPathType.Features,
    types: Set<MicroFeaturesType>,
    baseBuilder: Target.Builder? = nil
  ) -> [Self] {
    var targets: [Target] = []
    if types.contains(.interface) {
      targets.append(
        .feature(
          target: target,
          type: .interface,
          baseBuilder: baseBuilder
        )
      )
    }

    if types.contains(.source) {
      targets.append(
        .feature(
          target: target,
          type: .source,
          baseBuilder: baseBuilder
        )
      )
    }

    if types.contains(.testing) {
      targets.append(
        .feature(
          target: target,
          type: .testing,
          baseBuilder: baseBuilder
        )
      )
    }

    if types.contains(.tests) {
      targets.append(
        .feature(
          target: target,
          type: .tests,
          baseBuilder: baseBuilder
        )
      )
    }

    if types.contains(.examples) {
      targets.append(
        .feature(
          target: target,
          type: .examples,
          baseBuilder: baseBuilder
        )
      )
    }

    return targets
  }

  static func feature(
    target: ProjectPathType.Features,
    type: MicroFeaturesType,
    baseBuilder: Target.Builder? = nil
  ) -> Self {
    let builder: Target.Builder = .init()
    if let baseBuilder = baseBuilder {
      builder.builder(baseBuilder)
    }
    builder
      .scripts([.swiftLint])
      .sources(type.sourceFileList)
      .resources(type.resources)
      .name(type.name(target))

    let feturesDependencies = builder.featuresDependencies

    switch type {
    case .source:
      builder.product(.framework)
        .featuresDependencies(
          .init(source: feturesDependencies.sourceDependencies
                + [.feature(target: target, type: .interface)])
        )
    case .interface:
      builder.product(.framework)
        .featuresDependencies(
          .init(interface: feturesDependencies.interfaceDependencies
                + [.di, .core, .util]
               )
        )
    case .testing:
      builder.product(.framework)
        .featuresDependencies(
          .init(testing: feturesDependencies.testingDependencies
                + [.feature(target: target, type: .interface)])
        )
    case .tests:
      builder.product(.unitTests)
        .featuresDependencies(
          .init(tests: feturesDependencies.testsDependencies
                + [
                  .feature(target: target, type: .testing),
                  .feature(target: target, type: .source),
                  .xctest
                ])
        )
    case .examples:
      builder.product(.app)
        .infoPlist(.extendingDefault(with: [
          "UILaunchScreen" : .dictionary([:])
        ]))
        .featuresDependencies(
          .init(examples: feturesDependencies.examplesDependencies
                + [
                  .feature(target: target, type: .testing),
                  .feature(target: target, type: .source)
                ])
        )
    }
    return builder.build()
  }
}
