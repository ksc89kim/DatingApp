import ProjectDescription
import ProjectDescriptionHelpers
import ProjectPathPlugin

func targets() -> [Target] {
  return Target.features(
    target: .onboarding,
    types: .all,
    baseBuilder: .make(
      featuresDependencies: .init(
        source: [
          .feature(target: .appState, type: .interface)
        ],
        tests: [
          .feature(target: .appState, type: .testing)
        ]
      )
    )
  )
}

let project: Project = .feature(type: .onboarding, targets: targets())
