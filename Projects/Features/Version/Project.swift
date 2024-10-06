import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .feature(.version) {
  dependency(type: .interface) {
    feature(.launch, type: .interface)
  }
}
