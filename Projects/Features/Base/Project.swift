import ProjectDescription
import ProjectDescriptionHelpers
import ConfigurationPlugin
import EnvironmentPlugin
import ProjectPathPlugin

func targets() -> [Target] {
  return Target.features(target: .base, types: .all)
}

let project: Project = .feature(type: .base, targets: targets())
