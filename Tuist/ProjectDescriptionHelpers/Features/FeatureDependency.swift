//
//  FeatureDependency.swift
//  ProjectDescriptionHelpers
//
//  Created by kim sunchul on 9/29/24.
//

import ProjectDescription

public struct FeatureDependency {
  
  public let type: FeatureType
  
  public let dependecies: [TargetDependency]
}
