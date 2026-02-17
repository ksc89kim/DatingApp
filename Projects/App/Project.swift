import ProjectDescription
import ProjectDescriptionHelpers

nonisolated(unsafe) let configurationTargets: [ConfigurationTarget] = .default

let settings: Settings = .settings(
  base: .app,
  configurations: configurationTargets.configurations,
  defaultSettings: .recommended
)

let project = Project.make(
  name: env.name,
  settings: settings,
  schems: configurationTargets.schems(name: env.name)
) {
  Target.make(
    name: env.name,
    product: .app,
    bundleId: .appBundleId,
    infoPlist: .app,
    resources: ["Resources/**"],
    scripts: [.swiftLint]
  ) {
    feature(.appState, type: .source)
    feature(.launch, type: .source)
    feature(.version, type: .source)
    feature(.user, type: .source)
    feature(.onboarding, type: .source)
    feature(.main, type: .source)
    feature(.chat, type: .source)
    feature(.matching, type: .source)
  }
}
