import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .feature(.myPage) {
  dependency(type: .source) {
    feature(.appState, type: .interface)
    feature(.user, type: .interface)
  }
}
