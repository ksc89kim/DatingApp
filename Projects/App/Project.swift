import ProjectDescription
import ProjectDescriptionHelpers
import ConfigurationPlugin
import EnvironmentPlugin
import ProjectPathPlugin

let configurations: [Configuration] = .default

func targets() -> [Target] {
  return [
    .Builder()
    .name(env.name)
    .product(.app)
    .infoPlist("Support/Info.plist")
    .resources("Resources/**")
    .settings(.settings(base: env.baseSetting, configurations: configurations))
    .dependencies([
      .di
    ])
    .scripts([.swiftLint])
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


