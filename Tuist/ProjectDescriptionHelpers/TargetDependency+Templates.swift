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

  static var core: Self {
    return .project(
      target: "Core",
      path: .relativeToPathType(.core)
    )
  }

  static var util: Self {
    return .project(
      target: "Util",
      path: .relativeToPathType(.util)
    )
  }

  static var moya: Self {
    return .external(name: "Moya")
  }
}
