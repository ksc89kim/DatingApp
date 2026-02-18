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

      SWIFT_FILES=$(find . -name "*.swift" -not -path "*/Derived/*" -not -name "Project.swift" 2>/dev/null | head -1)
      if [ -z "$SWIFT_FILES" ]; then
        exit 0
      fi

      ${ROOT_DIR}/swiftlint --config ${ROOT_DIR}/.swiftlint.yml

      """,
      name: "SwiftLint",
      basedOnDependencyAnalysis: false
    )
  }
}
