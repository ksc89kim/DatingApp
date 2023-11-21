import ProjectDescription
import ProjectDescriptionHelpers
import ConfigurationPlugin
import EnvironmentPlugin

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
    .product(.unitTests)
    .appendDependenciess([
      .target(name: name)
    ])
    .build()
}

let project: Project = .init(
  name: name,
  organizationName: env.organizationName,
  options: env.options,
  settings: .base,
  targets: targets()
)
