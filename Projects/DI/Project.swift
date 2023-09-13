import ProjectDescription
import ProjectDescriptionHelpers
import ConfigurationPlugin
import EnvironmentPlugin

let name = "DI"

func targets() -> [Target] {
  return [
    .Builder.makeSource(name: name)
    .product(.framework)
    .build()
  ]
}

let project: Project = .init(
  name: name,
  organizationName: env.organizationName,
  settings: .base,
  targets: targets()
)
