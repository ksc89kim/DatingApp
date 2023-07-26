import Foundation
import ProjectDescription

public enum ConfigurationTarget: String {
  case dev = "Dev"
  case stage = "Stage"
  case release = "Release"

  // MARK: - Property

  public var configurationName: ConfigurationName {
    return ConfigurationName.configuration(self.rawValue)
  }
}


// MARK: - Path

public extension ConfigurationTarget {

  var path: ProjectDescription.Path {
    var path = "shared"
    switch self {
    case .dev: path = "app-dev"
    case .stage: path = "app-release"
    case .release: path = "app-stage"
    }
    return .relativeToRoot("Config/" + path + ".xcconfig")
  }
}
