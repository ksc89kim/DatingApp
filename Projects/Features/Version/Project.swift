import ProjectDescription
import ProjectDescriptionHelpers
import ProjectPathPlugin

func targets() -> [Target] {
  return Target.features(
    target: .version,
    types: .all,
    baseBuilder: .make(
      featuresDependencies: .init(
        interface: [
          .feature(target: .launch, type: .interface),
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

let project: Project = .feature(type: .version, targets: targets())
