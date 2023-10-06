import ProjectDescription
import ProjectDescriptionHelpers
import ProjectPathPlugin

func targets() -> [Target] {
  return Target.features(
    target: .appState,
    types: .all,
    baseBuilder: .make(
      featuresDependencies: .init(
        interface: [
          .di,
          .feature(target: .user, type: .interface)
        ]
      )
    )
  )
}

let project: Project = .feature(type: .appState, targets: targets())
