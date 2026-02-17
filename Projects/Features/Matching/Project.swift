import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .feature(.matching) {
  dependency(type: .source) {
    feature(.appState, type: .interface)
    feature(.user, type: .interface)
  }
}
