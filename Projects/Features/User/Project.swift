import ProjectDescription
import ProjectDescriptionHelpers
import ProjectPathPlugin

func targets() -> [Target] {
  return Target.features(target: .user, types: .all)
}

let project: Project = .feature(type: .user, targets: targets())
