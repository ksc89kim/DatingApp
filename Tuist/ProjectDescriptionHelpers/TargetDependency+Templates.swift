//
//  TargetDependency+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by kim sunchul on 2023/08/10.
//

import ProjectDescription


public enum external {
  public static var moya: TargetDependency = .external(name: "Moya")
  public static var naviagationTransitions: TargetDependency = .external(name: "NavigationTransitions")
  public static var kingfisher: TargetDependency = .external(name: "Kingfisher")
}
