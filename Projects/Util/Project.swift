import ProjectDescription
import ProjectDescriptionHelpers
import ConfigurationPlugin
import EnvironmentPlugin

let name = "Util"

func targets() -> [Target] {
  return [
    sourceTarget(),
    testsTarget()
  ]
}

func sourceTarget() -> Target {
  return .Builder.makeSource(name: name)
    .product(.framework)
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
  settings: .base,
  targets: targets()
)
