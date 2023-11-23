import ProjectDescription
import ProjectDescriptionHelpers
import ProjectPathPlugin

func targets() -> [Target] {

  return Target.features(
    target: .chat,
    types: .all,
    baseBuilder: .make(
      featuresDependencies: .init(
        source: [
          .feature(target: .appState, type: .interface)
        ]
      )
    )
  )
}

let project: Project = .feature(type: .chat, targets: targets())
