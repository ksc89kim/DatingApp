import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .feature(.home) {
  dependency(type: .source) {
    feature(.appState, type: .interface)
    feature(.matching, type: .interface)
    feature(.user, type: .interface)
  }
}
