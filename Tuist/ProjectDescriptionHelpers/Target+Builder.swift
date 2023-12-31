//
//  Target+Builder.swift
//  MicroFeaturesPlugin
//
//  Created by kim sunchul on 2023/07/27.
//

import ProjectDescription
import EnvironmentPlugin
import ConfigurationPlugin

public extension Target {

  // MARK: - Builder

  final class Builder {

    // MARK: - Property

    private var name: String

    private var platform: Platform

    private var product: Product

    private var productName: String?

    private var bundleId: String?

    private var deploymentTarget: DeploymentTarget

    private var infoPlist: InfoPlist

    private var sources: SourceFilesList

    private var resources: ResourceFileElements?

    private var copyFiles: [CopyFilesAction]?

    private var headers: Headers?

    private var entitlements: Entitlements? = nil

    private var scripts: [TargetScript]

    private var dependencies: [TargetDependency]

    public var featuresDependencies: MicroFeaturesDependencies

    private var settings: Settings?

    private var coreDataModels: [CoreDataModel]

    private var environmentVariables: [String: EnvironmentVariable]

    private var launchArguments: [LaunchArgument]

    private var additionalFiles: [FileElement]

    private var buildRules: [BuildRule]

    private var mergedBinaryType: MergedBinaryType

    private var mergeable: Bool

    // MARK: - Init

    public init(
      name: String = "",
      platform: Platform = env.platform,
      product: Product = .staticFramework,
      productName: String? = nil,
      bundleId: String? = nil,
      deploymentTarget: DeploymentTarget = env.deploymentTarget,
      infoPlist: InfoPlist = .default,
      sources: SourceFilesList = "Sources/**",
      resources: ResourceFileElements? = nil,
      copyFiles: [CopyFilesAction]? = nil,
      headers: Headers? = nil,
      entitlements: Entitlements? = nil,
      scripts: [TargetScript] = [],
      dependencies: [TargetDependency] = [],
      featuresDependencies: MicroFeaturesDependencies = .init(),
      settings: Settings? = .settings(
        base: env.baseSetting,
        configurations: .default
      ),
      coreDataModels: [CoreDataModel] = [],
      environmentVariables: [String: EnvironmentVariable] = [:],
      launchArguments: [LaunchArgument] = [],
      additionalFiles: [FileElement] = [],
      buildRules: [BuildRule] = [],
      mergedBinaryType: MergedBinaryType = .disabled,
      mergeable: Bool = false
    ) {
      self.name = name
      self.platform = platform
      self.product = product
      self.productName = productName
      self.bundleId = bundleId
      self.deploymentTarget = deploymentTarget
      self.infoPlist = infoPlist
      self.sources = sources
      self.resources = resources
      self.copyFiles = copyFiles
      self.headers = headers
      self.entitlements = entitlements
      self.scripts = scripts
      self.dependencies = dependencies
      self.featuresDependencies = featuresDependencies
      self.settings = settings
      self.coreDataModels = coreDataModels
      self.environmentVariables = environmentVariables
      self.launchArguments = launchArguments
      self.additionalFiles = additionalFiles
      self.buildRules = buildRules
      self.mergedBinaryType = mergedBinaryType
      self.mergeable = mergeable
    }

    // MARK: - Build Methods

    public func build() -> Target {
      var targetDependencies: [TargetDependency] = []
      targetDependencies += self.dependencies
      targetDependencies += self.featuresDependencies.interfaceDependencies
      targetDependencies += self.featuresDependencies.sourceDependencies
      targetDependencies += self.featuresDependencies.examplesDependencies
      targetDependencies += self.featuresDependencies.testingDependencies
      targetDependencies += self.featuresDependencies.testsDependencies

      return .init(
        name: self.name,
        platform: self.platform,
        product: self.product,
        productName: self.productName,
        bundleId: self.bundleId ?? "\(env.organizationName).\(name)",
        deploymentTarget: self.deploymentTarget,
        infoPlist: self.infoPlist,
        sources: self.sources,
        resources: self.resources,
        entitlements: self.entitlements,
        scripts: self.scripts,
        dependencies: targetDependencies,
        settings: self.settings,
        coreDataModels: self.coreDataModels,
        environmentVariables: self.environmentVariables,
        launchArguments: self.launchArguments,
        additionalFiles: self.additionalFiles,
        buildRules: self.buildRules,
        mergedBinaryType: self.mergedBinaryType,
        mergeable: self.mergeable
      )
    }

    // MARK: - Methods

    @discardableResult
    public func name(_ name: String) -> Self {
      self.name = name
      return self
    }

    @discardableResult
    public func platform(_ platform: Platform) -> Self {
      self.platform = platform
      return self
    }

    @discardableResult
    public func product(_ product: Product) -> Self {
      self.product = product
      return self
    }

    @discardableResult
    public func productName(_ productName: String) -> Self {
      self.productName = productName
      return self
    }

    @discardableResult
    public func bundleId(_ bundleId: String) -> Self {
      self.bundleId = bundleId
      return self
    }

    @discardableResult
    public func deploymentTarget(_ deploymentTarget: DeploymentTarget) -> Self {
      self.deploymentTarget = deploymentTarget
      return self
    }

    @discardableResult
    public func infoPlist(_ infoPlist: InfoPlist) -> Self {
      self.infoPlist = infoPlist
      return self
    }

    @discardableResult
    public func sources(_ sources: SourceFilesList) -> Self {
      self.sources = sources
      return self
    }

    @discardableResult
    public func resources(_ resources: ResourceFileElements?) -> Self {
      self.resources = resources
      return self
    }

    @discardableResult
    public func copyFiles(_ copyFiles: [CopyFilesAction]) -> Self {
      self.copyFiles = copyFiles
      return self
    }

    @discardableResult
    public func headers(_ headers: Headers) -> Self {
      self.headers = headers
      return self
    }

    @discardableResult
    public func entitlements(_ entitlements: Entitlements) -> Self {
      self.entitlements = entitlements
      return self
    }

    public func scripts(_ scripts: [TargetScript]) -> Self {
      self.scripts = scripts
      return self
    }

    @discardableResult
    public func appendDependenciess(_ dependencies: [TargetDependency]) -> Self {
      self.dependencies.append(contentsOf: dependencies)
      return self
    }

    @discardableResult
    public func dependencies(_ dependencies: [TargetDependency]) -> Self {
      self.dependencies = dependencies
      return self
    }

    @discardableResult
    public func featuresDependencies(_ dependencies: MicroFeaturesDependencies) -> Self {
      self.featuresDependencies = dependencies
      return self
    }

    @discardableResult
    public func settings(_ settings: Settings) -> Self {
      self.settings = settings
      return self
    }

    @discardableResult
    public func coreDataModels(_ coreDataModels: [CoreDataModel]) -> Self {
      self.coreDataModels = coreDataModels
      return self
    }

    @discardableResult
    public func environmentVariables(_ environmentVariables: [String: EnvironmentVariable]) -> Self {
      self.environmentVariables = environmentVariables
      return self
    }

    @discardableResult
    public func launchArguments(_ launchArguments: [LaunchArgument]) -> Self {
      self.launchArguments = launchArguments
      return self
    }

    @discardableResult
    public func additionalFiles(_ additionalFiles: [FileElement]) -> Self {
      self.additionalFiles = additionalFiles
      return self
    }

    @discardableResult
    public func buildRules(_ buildRules: [BuildRule]) -> Self {
      self.buildRules = buildRules
      return self
    }

    @discardableResult
    public func mergedBinaryType(_ mergedBinaryType: MergedBinaryType) -> Self {
      self.mergedBinaryType = mergedBinaryType
      return self
    }

    @discardableResult
    public func mergeable(_ mergeable: Bool) -> Self {
      self.mergeable = mergeable
      return self
    }

    @discardableResult
    public func builder(_ builder: Builder) -> Self {
      self.name = builder.name
      self.platform = builder.platform
      self.product = builder.product
      self.productName = builder.productName
      self.bundleId = builder.bundleId
      self.deploymentTarget = builder.deploymentTarget
      self.infoPlist = builder.infoPlist
      self.sources = builder.sources
      self.resources = builder.resources
      self.copyFiles = builder.copyFiles
      self.headers = builder.headers
      self.entitlements = builder.entitlements
      self.scripts = builder.scripts
      self.dependencies = builder.dependencies
      self.featuresDependencies = builder.featuresDependencies
      self.settings = builder.settings
      self.coreDataModels = builder.coreDataModels
      self.environmentVariables = builder.environmentVariables
      self.launchArguments = builder.launchArguments
      self.additionalFiles = builder.additionalFiles
      self.buildRules = builder.buildRules
      self.mergedBinaryType = builder.mergedBinaryType
      self.mergeable = builder.mergeable
      return self
    }

    public static func make(dependencies: [TargetDependency]) -> Self {
      return .init().dependencies(dependencies)
    }

    public static func make(featuresDependencies: MicroFeaturesDependencies) -> Self {
      return .init().featuresDependencies(featuresDependencies)
    }

    public static func makeSource(
      name: String,
      settings: Settings = .base
    ) -> Self {
      return .init()
        .name(name)
        .settings(settings)
        .scripts([.swiftLint])
    }

    public static func makeTests(
      name: String,
      settings: Settings = .base
    ) -> Self {
      return .init()
        .name(name + "Tests")
        .sources("Tests/**")
        .settings(settings)
        .dependencies([.xctest])
        .scripts([.swiftLint])
    }
  }
}
