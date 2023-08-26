//
//  Settings+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by kim sunchul on 2023/08/26.
//

import ProjectDescription
import EnvironmentPlugin

public extension Settings {

  static var base: Self {
    return .settings(
      base: env.baseSetting,
      configurations: .default,
      defaultSettings: .recommended
    )
  }
}
