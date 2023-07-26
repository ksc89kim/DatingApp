//
//  Scheme+ConfigurationTarget.swift
//  ConfigurationPlugin
//
//  Created by kim sunchul on 2023/07/26.
//

import ProjectDescription

public extension Scheme {

  // MARK: - Methods
  
  static func make(name: String, target: ConfigurationTarget) -> Self {
    return .init(
      name: name + target.rawValue,
      shared: true,
      buildAction: .buildAction(targets: ["\(name)"]),
      runAction: .runAction(configuration: target.configurationName),
      archiveAction: .archiveAction(configuration: target.configurationName),
      profileAction: .profileAction(configuration: target.configurationName),
      analyzeAction: .analyzeAction(configuration: target.configurationName)
    )
  }
}
