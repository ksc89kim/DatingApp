//
//  MicroFeaturesType+Name.swift
//  ProjectDescriptionHelpers
//
//  Created by kim sunchul on 2023/07/31.
//

import Foundation
import ProjectPathPlugin

public extension MicroFeaturesType {

  func name(_ type: ProjectPathType.Features) -> String {
    if case .source = self {
      return type.rawValue
    }
    return type.rawValue + self.rawValue
  }
}
