import ProjectDescription
import ProjectDescriptionHelpers
import ProjectPathPlugin

func targets() -> [Target] {
  return Target.features(target: .version, types: .all)
}

let project: Project = .feature(type: .version, targets: targets())
