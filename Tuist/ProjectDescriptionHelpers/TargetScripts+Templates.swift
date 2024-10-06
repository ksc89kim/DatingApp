//
//  TargetScripts+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by kim sunchul on 2023/08/22.
//

import ProjectDescription
import Foundation

public extension TargetScript {

  static var swiftLint: Self {
    return .pre(
      script: """
      ROOT_DIR=\(Environment.rootDir.getString(default: ""))
              
      ${ROOT_DIR}/swiftlint --config ${ROOT_DIR}/.swiftlint.yml
              
      """,
      name: "SwiftLint",
      basedOnDependencyAnalysis: false
    )
  }
}
