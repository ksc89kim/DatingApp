import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .feature(.chat) {
  dependency(type: .source) {
    feature(.appState, type: .interface)
    external.kingfisher
  }
}
