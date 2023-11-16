import ProjectDescription
import ProjectDescriptionHelpers
import ProjectPathPlugin

func targets() -> [Target] {
  return Target.features(
    target: .user,
    types: .all,
    baseBuilder: .make(
      featuresDependencies: .init(
        interface: [
          .di,
          .core,
          .feature(target: .launch, type: .interface)
        ],
        source: [
          .core,
          .di,
          .util,
          .feature(target: .launch, type: .interface),
          .feature(target: .appState, type: .interface)
        ],
        examples: [
          .core,
          .di,
          .util,
          .feature(target: .appState, type: .interface),
          .feature(target: .appState, type: .testing)
        ],
        tests: [
          .core,
          .di
        ]
      )
    )
  )
}

let project: Project = .feature(type: .user, targets: targets())
