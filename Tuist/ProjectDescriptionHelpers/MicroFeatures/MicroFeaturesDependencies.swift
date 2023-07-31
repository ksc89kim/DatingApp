//
//  MicroFeaturesDependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by kim sunchul on 2023/07/31.
//

import ProjectDescription

public struct MicroFeaturesDependencies {

  // MARK: - Property

  public var interfaceDependencies: [TargetDependency]

  public let sourceDependencies: [TargetDependency]

  public let examplesDependencies: [TargetDependency]

  public let testingDependencies: [TargetDependency]

  public let testsDependencies: [TargetDependency]

  // MARK: - Init

  public init(
    interface: [TargetDependency] = [],
    source: [TargetDependency] = [],
    examples: [TargetDependency] = [],
    testing: [TargetDependency] = [],
    tests: [TargetDependency] = []
  ) {
    self.interfaceDependencies = interface
    self.sourceDependencies = source
    self.examplesDependencies = examples
    self.testingDependencies = testing
    self.testsDependencies = tests
  }
}
