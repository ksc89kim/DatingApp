import ProjectDescription
import ProjectDescriptionHelpers

nonisolated(unsafe) let configurationTargets: [ConfigurationTarget] = .default
nonisolated(unsafe) let type: ProjectType = .util
let settings: Settings = .settings(
  base: .base,
  configurations: configurationTargets.configurations,
  defaultSettings: .recommended
)

let project = Project.make(
  name: type.name,
  settings: settings
) {
  Target.sources(
    name: type.name,
    resources: ["Resources/**"]
  ) {
    external.naviagationTransitions
  }
  Target.tests(
    name: type.name
  ) {}
}
