import ProjectDescription
import ProjectDescriptionHelpers
import ConfigurationPlugin
import EnvironmentPlugin

let configurations: [Configuration] = .default

let targets: [Target] = [
  .init(
    name: env.name,
    platform: env.platform,
    product: .app,
    bundleId: env.bundleId,
    deploymentTarget: env.deploymentTarget,
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    settings: .settings(base: env.baseSetting)
  )
]


let project: Project = .init(
  name: env.name,
  organizationName: env.organizationName,
  settings: .settings(base: env.baseSetting, configurations: configurations),
  targets: targets,
  schemes: configurations.schems(name: env.name)
)


