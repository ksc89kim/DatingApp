//
//  TargetDependency+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by kim sunchul on 2023/08/10.
//

import ProjectDescription
import ProjectPathPlugin

public extension TargetDependency {

  static var di: Self {
    return .project(
      target: "DI",
      path: .relativeToPathType(.di)
    )
  }

  static var moya: Self {
    return .external(name: "Moya")
  }
}
