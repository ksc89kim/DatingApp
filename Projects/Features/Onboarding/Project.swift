import ProjectDescription
import ProjectDescriptionHelpers
import ProjectPathPlugin

func targets() -> [Target] {
  return Target.features(
    target: .onboarding,
    types: .all,
    baseBuilder: .make(
      featuresDependencies: .init(
        interface: [
          .di,
          .core
        ],
        source: [
          .core,
          .util,
          .di,
          .feature(target: .appState, type: .interface)
        ],
        examples: [
          .di,
          .feature(target: .appState, type: .interface)
        ],
        tests: [
          .di,
          .core
        ]
        + TargetDependency.features(
          target: .appState,
          types: [.interface, .testing]
        )
      )
    )
  )
}

let project: Project = .feature(type: .onboarding, targets: targets())
