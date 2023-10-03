import ProjectDescription
import ProjectDescriptionHelpers
import ProjectPathPlugin

func targets() -> [Target] {
  return Target.features(
    target: .appState,
    types: .all,
    baseBuilder: .make(dependencies: [.di])
  )
}

let project: Project = .feature(type: .appState, targets: targets())
