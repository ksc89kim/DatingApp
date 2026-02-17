//
//  Target+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by kim sunchul on 9/10/24.
//

import ProjectDescription

public extension Target {
  
  static func feature(
    _ features: ProjectType.Features,
    type: FeatureType,
    dependencies: [TargetDependency]
  ) -> Target {
    return .make(
      name: type.name(features),
      product: type.product,
      bundleId: type.bundleId(name: features.rawValue),
      infoPlist: type.infoPlist,
      sources: type.sourceFileList,
      resources: type.resources,
      scripts: [.swiftLint],
      dependencies: dependencies
    )
  }
  
  static func tests(
    name: String,
    @ConfigurationBuilder<TargetDependency> _ content: () -> [TargetDependency]
  ) -> Target {
    return .make(
      name: name + "Tests",
      product: .unitTests,
      bundleId: .tests(name: name),
      sources: ["Tests/**"],
      scripts: [.swiftLint],
      content
    )
  }
  
  static func sources(
    name: String,
    product: Product = Environment.forPreview.getBoolean(default: false) ? .framework : .staticFramework,
    resources: ResourceFileElements? = nil,
    @ConfigurationBuilder<TargetDependency> _ content: () -> [TargetDependency]
  ) -> Target {
    print(Environment.forPreview.getString(default: "EMPTY"))
    return .make(
      name: name,
      product: product,
      bundleId: .sources(name: name),
      resources: resources,
      scripts: [.swiftLint],
      content
    )
  }
  
  static func make(
    name: String,
    product: Product = .staticFramework,
    bundleId: String,
    infoPlist: InfoPlist = .default,
    sources: SourceFilesList? = ["Sources/**"],
    resources: ResourceFileElements? = nil,
    entitlements: Entitlements? = nil,
    scripts: [TargetScript] = [],
    @ConfigurationBuilder<TargetDependency> _ content: () -> [TargetDependency]
  ) -> Target {
    return .make(
      name: name,
      product: product,
      bundleId: bundleId,
      infoPlist: infoPlist,
      sources: sources,
      resources: resources,
      entitlements: entitlements,
      scripts: scripts,
      dependencies: content()
    )
  }
  static func make(
    name: String,
    destinations: Destinations = env.destinations,
    deploymentTarget: DeploymentTargets = env.deploymentTarget,
    product: Product = .staticFramework,
    bundleId: String,
    infoPlist: InfoPlist = .default,
    sources: SourceFilesList? = ["Sources/**"],
    resources: ResourceFileElements? = nil,
    entitlements: Entitlements? = nil,
    scripts: [TargetScript] = [],
    dependencies: [TargetDependency] = []
  ) -> Target {
    return .target(
      name: name,
      destinations: destinations,
      product: product,
      bundleId: bundleId,
      deploymentTargets: deploymentTarget,
      infoPlist: infoPlist,
      sources: sources,
      resources: resources,
      scripts: scripts,
      dependencies: dependencies
    )
  }
}
