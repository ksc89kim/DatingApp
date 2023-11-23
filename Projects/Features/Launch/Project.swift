import ProjectDescription
import ProjectDescriptionHelpers
import ProjectPathPlugin

func targets() -> [Target] {
  return Target.features(
    target: .launch,
    types: .all,
    baseBuilder: .make(
      featuresDependencies: .init(
        source: [
          .feature(target: .appState, type: .interface),
          .feature(target: .version, type: .interface),
          .feature(target: .user, type: .interface),
          .feature(target: .onboarding, type: .interface)
        ]
      )
    )
  )
}

let project: Project = .feature(type: .launch, targets: targets())
