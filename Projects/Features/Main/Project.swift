import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .feature(.main) {
  dependency(type: .source) {
    feature(.chat, type: .interface)
    feature(.matching, type: .interface)
    feature(.myPage, type: .interface)
  }
}
