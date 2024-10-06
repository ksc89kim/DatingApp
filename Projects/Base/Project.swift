import ProjectDescription
import ProjectDescriptionHelpers

let configurationTargets: [ConfigurationTarget] = .default
let type: ProjectType = .base
let settings: Settings = .settings(
  base: .base,
  configurations: configurationTargets.configurations,
  defaultSettings: .recommended
)

let project = Project.make(
  name: type.name,
  settings: settings
) {
  Target.sources(name: type.name) {
    dependency(.di)
    dependency(.core)
    dependency(.util)
  }
}
