import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .feature(.appState) {
  dependency(type: .interface) {
    feature(.user, type: .interface)
  }
}
