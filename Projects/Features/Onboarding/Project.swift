import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .feature(.onboarding) {
  dependency(type: .source) {
    feature(.appState, type: .interface)
  }
}
