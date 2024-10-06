import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .feature(.main) {
  dependency(type: .source) {
    feature(.chat, type: .interface)
  }
}
