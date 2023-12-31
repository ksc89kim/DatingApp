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
          .feature(target: .launch, type: .interface)
        ],
        source: [
          .feature(target: .appState, type: .interface)
        ]
      )
    )
  )
}

let project: Project = .feature(type: .user, targets: targets())
