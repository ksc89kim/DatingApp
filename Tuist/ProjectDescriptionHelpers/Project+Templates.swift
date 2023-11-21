import ProjectDescription
import ProjectPathPlugin
import EnvironmentPlugin
import ConfigurationPlugin

public extension Project {

  static func feature(
    type: ProjectPathType.Features,
    targets: [Target] = [],
    settings: Settings? = .base
  ) -> Project {

    return .init(
      name: type.rawValue,
      organizationName: env.organizationName,
      options: env.options,
      settings: settings,
      targets: targets
    )
  }
}
