//
//  Scheme+ConfigurationTarget.swift
//  ProjectDescriptionHelpers
//
//  Created by kim sunchul on 2023/07/26.
//

import ProjectDescription

public extension Scheme {

  // MARK: - Methods
  
  static func make(name: String, target: ConfigurationTarget) -> Self {
    return .scheme(
      name: name + target.type.rawValue,
      shared: true,
      buildAction: .buildAction(targets: ["\(name)"]),
      runAction: .runAction(configuration: target.type.name, arguments: target.arguments),
      archiveAction: .archiveAction(configuration: target.type.name),
      profileAction: .profileAction(configuration: target.type.name),
      analyzeAction: .analyzeAction(configuration: target.type.name)
    )
  }
}
