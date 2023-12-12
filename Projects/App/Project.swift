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
      .util,
      .kingfisher,
      .feature(target: .appState, type: .source),
      .feature(target: .appState, type: .interface),
      .feature(target: .launch, type: .source),
      .feature(target: .launch, type: .interface),
      .feature(target: .version, type: .source),
      .feature(target: .version, type: .interface),
      .feature(target: .user, type: .source),
      .feature(target: .user, type: .interface),
      .feature(target: .onboarding, type: .source),
      .feature(target: .onboarding, type: .interface),
      .feature(target: .main, type: .source),
      .feature(target: .main, type: .interface),
      .feature(target: .chat, type: .source),
      .feature(target: .chat, type: .interface)
    ])
    .build()
  ]
}

let project: Project = .init(
  name: env.name,
  organizationName: env.organizationName,
  options: env.options,
  settings: settings,
  targets: targets(),
  schemes: configurations.schems(name: env.name)
)
