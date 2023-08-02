import ProjectDescription
import ProjectDescriptionHelpers
import ConfigurationPlugin
import EnvironmentPlugin

let configurations: [Configuration] = .default

func targets() -> [Target] {
  return [
    .Builder()
    .name(env.name)
    .product(.app)
    .settings(.settings(base: env.baseSetting, configurations: configurations))
    .build()
  ]
}

let project: Project = .init(
  name: env.name,
  organizationName: env.organizationName,
  settings: .settings(
    base: env.baseSetting,
    configurations: configurations
  ),
  targets: targets(),
  schemes: configurations.schems(name: env.name)
)


