import ProjectDescription
import ProjectDescriptionHelpers
import ProjectPathPlugin

func targets() -> [Target] {
  return Target.features(
    target: .version,
    types: .all,
    baseBuilder: .make(
      featuresDependencies: .init(
        source: [.core]
      )
    )
  )
}

let project: Project = .feature(type: .version, targets: targets())
