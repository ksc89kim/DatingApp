import ProjectDescription
import ProjectDescriptionHelpers
import ConfigurationPlugin
import EnvironmentPlugin
import ProjectPathPlugin

let configurations: [Configuration] = .default
let name = "Core"

func targets() -> [Target] {
  return [
    .Builder()
    .name(name)
    .product(.framework)
    .settings(
      .settings(
        base: env.baseSetting,
        configurations: configurations
      )
    )
    .dependencies([
      .moya
    ])
    .scripts([.swiftLint])
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


