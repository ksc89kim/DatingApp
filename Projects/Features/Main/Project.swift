import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .feature(.main) {
  dependency(type: .source) {
    feature(.appState, type: .interface)
    feature(.chat, type: .interface)
    feature(.matching, type: .interface)
    feature(.myPage, type: .interface)
    feature(.user, type: .interface)
  }
}
