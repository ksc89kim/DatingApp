import ProjectDescription

public extension Project {
  
  static func feature(
    _ projectType: ProjectType.Features,
    type: Set<FeatureType> = .all,
    targets: [Target] = [],
    @ConfigurationBuilder<FeatureDependency> _ content: () -> [FeatureDependency]
  ) -> Project {
    let featureDependencies = content()
    let featureTargets = type.map { (type: FeatureType) -> Target in
      let featureDependency = featureDependencies.first { featureDependency in featureDependency.type == type }
      let baseDependencies = type.dependencyIfNeeded(projectType)
      return .feature(
        projectType,
        type: type,
        dependencies: (featureDependency?.dependecies ?? []) + baseDependencies
      )
    }
    
    return .init(
      name: projectType.rawValue,
      options: .options(
        defaultKnownRegions: env.defaultKnownRegions,
        developmentRegion: env.developmentRegion
      ),
      settings: .settings(
        base: .base,
        configurations: [ConfigurationTarget].default.configurations,
        defaultSettings: .recommended
      ),
      targets: featureTargets + targets
    )
  }
  
  static func make(
    name: String,
    options: Options = .options(
      defaultKnownRegions: env.defaultKnownRegions,
      developmentRegion: env.developmentRegion
    ),
    settings: Settings? = nil,
    schems: [Scheme] = [],
    @ConfigurationBuilder<Target> _ content: () -> [Target]
  ) -> Project {
    return .init(
      name: name,
      organizationName: env.organizationName,
      options: options,
      settings: settings,
      targets: content(),
      schemes: schems
    )
  }
}
