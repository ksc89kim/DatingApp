import Foundation
import ProjectDescription

public enum ConfigurationTargetType: String {
  case dev = "Dev"
  case stage = "Stage"
  case release = "Release"
  
  // MARK: - Property
  
  public var name: ConfigurationName {
    return ConfigurationName.configuration(self.rawValue)
  }
}


public struct ConfigurationTarget {
  
  public let type: ConfigurationTargetType
  
  public let arguments: Arguments?
  
  public var path: ProjectDescription.Path {
    var path = "shared"
    switch self.type {
    case .dev: path = "app-dev"
    case .stage: path = "app-release"
    case .release: path = "app-stage"
    }
    return .relativeToRoot("Config/" + path + ".xcconfig")
  }
  
  public var configuration: Configuration {
    switch self.type {
    case .dev, .stage: return .debug(name: self.type.name, xcconfig: self.path)
    case .release: return .release(name: self.type.name, xcconfig: self.path)
    }
  }
  
  public init(type: ConfigurationTargetType, arguments: Arguments? = nil) {
    self.type = type
    self.arguments = arguments
  }
}


// MARK: - ConfigurationTarget Builder

public extension ConfigurationTarget {
  
  static var dev: ConfigurationTarget {
    return .init(type: .dev, arguments: .arguments())
  }
  
  static var stage: ConfigurationTarget {
    return .init(type: .stage)
  }
  
  static var release: ConfigurationTarget {
    return .init(type: .release)
  }
}


// MARK: - ConfigurationTarget Array

public extension Array where Element == ConfigurationTarget {
  
    nonisolated(unsafe) static let `default`: [ConfigurationTarget] = [
    .dev,
    .stage,
    .release
  ]
  
  var configurations: [Configuration] {
    return self.map { (target: ConfigurationTarget) -> Configuration in
      return target.configuration
    }
  }
  
  func schems(name: String) -> [Scheme] {
    return self.map { (target: ConfigurationTarget) -> Scheme in
      return .make(name: name, target: target)
    }
  }
}
