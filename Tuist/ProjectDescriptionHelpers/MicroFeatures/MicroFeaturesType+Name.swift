//
//  MicroFeaturesType+Name.swift
//  ProjectDescriptionHelpers
//
//  Created by kim sunchul on 2023/07/31.
//

import Foundation

public extension MicroFeaturesType {

  func name(name: String) -> String {
    return name + self.rawValue
  }
}
