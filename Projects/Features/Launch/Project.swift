import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .feature(.launch) {
  dependency(type: .source) {
    feature(.appState, type: .interface)
    feature(.version, type: .interface)
    feature(.user, type: .interface)
    feature(.onboarding, type: .interface)
  }
}
