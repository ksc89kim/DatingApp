import ProjectDescription
import ProjectDescriptionHelpers
import ConfigurationPlugin
import EnvironmentPlugin

let configurations: [Configuration] = .default
let name = "DI"

func targets() -> [Target] {
  return [
    .Builder()
    .name(name)
    .product(.framework)
    .settings(.settings(base: env.baseSetting, configurations: configurations))
    .build()
  ]
}

let project: Project = .init(
  name: name,
  organizationName: env.organizationName,
  settings: .settings(
    base: env.baseSetting,
    configurations: configurations
  ),
  targets: targets()
)


