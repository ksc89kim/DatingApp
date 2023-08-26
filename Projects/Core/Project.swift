import ProjectDescription
import ProjectDescriptionHelpers
import ConfigurationPlugin
import EnvironmentPlugin

let configurations: [Configuration] = .default
let name = "Core"

func targets() -> [Target] {
  return [
    sourceTarget(),
    testsTarget()
  ]
}

func sourceTarget() -> Target {
  return .Builder.makeSource(name: name)
    .product(.framework)
    .appendDependenciess([
      .moya
    ])
    .build()
}

func testsTarget() -> Target {
  return .Builder.makeTests(name: name)
    .appendDependenciess([
      .target(name: name)
    ])
    .build()
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
