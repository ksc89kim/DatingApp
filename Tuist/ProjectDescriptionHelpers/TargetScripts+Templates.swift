//
//  TargetScripts+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by kim sunchul on 2023/08/22.
//

import ProjectDescription

public extension TargetScript {

  static var swiftLint: Self {
    return .pre(
      path: .relativeToRoot("Scripts/SwiftLint/SwiftLintRunScript.sh"),
      name: "SwiftLint",
      basedOnDependencyAnalysis: false
    )
  }
}
