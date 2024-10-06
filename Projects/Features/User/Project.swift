import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .feature(.user) {
  dependency(type: .interface) {
    feature(.launch, type: .interface)
  }
  dependency(type: .source) {
    feature(.appState, type: .interface)
  }
}
