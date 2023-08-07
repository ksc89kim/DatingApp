import ProjectDescription
import ProjectDescriptionHelpers
import ProjectPathPlugin

func targets() -> [Target] {
  return Target.features(target: .launch, types: .all)
}

let project: Project = .feature(type: .launch, targets: targets())
