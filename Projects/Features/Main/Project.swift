import ProjectDescription
import ProjectDescriptionHelpers
import ProjectPathPlugin

func targets() -> [Target] {
  return Target.features(
    target: .main,
    types: .all,
    baseBuilder: .make(
      featuresDependencies: .init(
        source: [
          .feature(target: .chat, type: .interface)
        ]
      )
    )
  )
}
let project: Project = .feature(type: .main, targets: targets())
