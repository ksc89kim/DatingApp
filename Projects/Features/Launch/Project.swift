import ProjectDescription
import ProjectDescriptionHelpers
import ProjectPathPlugin

func targets() -> [Target] {
  return Target.features(
    target: .launch,
    types: .all,
    baseBuilder: .make(
      featuresDependencies: .init(
        source: [.core]
      )
    )
  )
}

let project: Project = .feature(type: .launch, targets: targets())
