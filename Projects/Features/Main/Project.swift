import ProjectDescription
import ProjectDescriptionHelpers
import ProjectPathPlugin

func targets() -> [Target] {
  return Target.features(target: .main, types: .all)
}

let project: Project = .feature(type: .main, targets: targets())
