//
//  ProjectDescriptionPath+ProjectPathType.swift
//  PathPlugin
//
//  Created by kim sunchul on 2023/07/31.
//

import ProjectDescription

public extension ProjectDescription.Path {

  static func relativeToPathType(_ type: ProjectPathType) -> Self {
    return .relativeToRoot(type.path)
  }
}
