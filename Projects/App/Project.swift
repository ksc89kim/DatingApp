import ProjectDescription
import ProjectDescriptionHelpers
import ConfigurationPlugin
import EnvironmentPlugin
import ProjectPathPlugin

let configurations: [Configuration] = .default

let settings: Settings = .settings(
  base: env.baseSetting,
  configurations: configurations,
  defaultSettings: .recommended
)

func targets() -> [Target] {
  return [
    .Builder.makeSource(
      name: env.name,
      settings: settings
    )
    .product(.app)
    .infoPlist("Support/Info.plist")
    .resources("Resources/**")
    .appendDependenciess([
      .di,
      .core,
      .feature(target: .launch, type: .source),
      .feature(target: .version, type: .source)
    ])
    .build()
  ]
}

let project: Project = .init(
  name: env.name,
  organizationName: env.organizationName,
  settings: settings,
  targets: targets(),
  schemes: configurations.schems(name: env.name)
)
