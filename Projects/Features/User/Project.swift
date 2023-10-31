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
          .di
        ],
        source: [
          .core,
          .di,
          .feature(target: .launch, type: .interface)
        ]
      )
    )
  )
}

let project: Project = .feature(type: .user, targets: targets())
