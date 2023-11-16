import ProjectDescription
import ProjectDescriptionHelpers
import ProjectPathPlugin

func targets() -> [Target] {
  return Target.features(
    target: .launch,
    types: .all,
    baseBuilder: .make(
      featuresDependencies: .init(
        interface: [
          .di,
          .core
        ],
        source: [
          .core,
          .di,
          .util,
          .feature(target: .appState, type: .interface),
          .feature(target: .version, type: .interface),
          .feature(target: .user, type: .interface),
          .feature(target: .onboarding, type: .interface)
        ],
        examples: [
          .core,
          .di,
          .feature(target: .version, type: .interface),
          .feature(target: .appState, type: .interface)
        ],
        tests: [
          .di,
          .feature(target: .version, type: .interface)
        ]
        + TargetDependency.features(
          target: .appState,
          types: [.interface, .testing]
        )
      )
    )
  )
}

let project: Project = .feature(type: .launch, targets: targets())
