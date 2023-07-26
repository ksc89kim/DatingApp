//
//  Configuration+ConfigurationTarget.swift
//  EnvironmentPlugin
//
//  Created by kim sunchul on 2023/07/26.
//

import ProjectDescription

public extension Configuration {

  // MARK: - Property

  var target: ConfigurationTarget? {
    return .init(rawValue: self.name.rawValue)
  }


  // MARK: - Methods

  static func debug(target: ConfigurationTarget) -> Self {
    return .debug(name: target.configurationName, xcconfig: target.path)
  }

  static func release(target: ConfigurationTarget) -> Self {
    return .release(name: target.configurationName, xcconfig: target.path)
  }
}


// MARK: - Configuration Array

public extension Array where Element == Configuration {

  // MARK: - Property

  static let `default`: [Configuration] = [
    .debug(target: .dev),
    .debug(target: .stage),
    .release(target: .release)
  ]

  var targets: [ConfigurationTarget] {
    return self.compactMap { (configuration: Configuration) -> ConfigurationTarget? in
      return configuration.target
    }
  }

  func schems(name: String) -> [Scheme] {
    return self.targets.map { (target: ConfigurationTarget) -> Scheme in
      return .make(name: name, target: target)
    }
  }
}
