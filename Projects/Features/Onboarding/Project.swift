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
          .di
        ],
        source: [
          .core,
          .di
        ]
      )
    )
  )
}

let project: Project = .feature(type: .onboarding, targets: targets())
