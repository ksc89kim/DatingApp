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
}
