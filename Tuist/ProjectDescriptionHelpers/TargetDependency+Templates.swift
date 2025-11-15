//
//  TargetDependency+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by kim sunchul on 2023/08/10.
//

import ProjectDescription


public enum external {
    public static let moya: TargetDependency = .external(name: "Moya")
    public static let naviagationTransitions: TargetDependency = .external(name: "SwiftUINavigationTransitions")
    public static let kingfisher: TargetDependency = .external(name: "Kingfisher")
}
