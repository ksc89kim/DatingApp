import ProjectDescription
import ProjectDescriptionHelpers
import ProjectPathPlugin

func targets() -> [Target] {
  return Target.features(
    target: .launch,
    types: .all,
    baseBuilder: .make(
      featuresDependencies: .init(
        interface: [
          .di,
          .core
        ],
        source: [
          .core,
          .di,
          .util,
          .feature(target: .version, type: .interface)
        ]
      )
    )
  )
}

let project: Project = .feature(type: .launch, targets: targets())
