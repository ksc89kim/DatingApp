//
//  ConfigurationBuilder.swift
//  ProjectDescriptionHelpers
//
//  Created by kim sunchul on 9/10/24.
//

import ProjectDescription

@resultBuilder
public struct ConfigurationBuilder<Component> {
  
  public static func buildBlock(_ components: Component...) -> [Component] {
    return components
  }
  
  public static func buildEither(first component: Component) -> Component {
    return component
  }
  
  public static func buildEither(second component: Component) -> Component {
    return component
  }
  
  public static func buildOptional(_ component: Component?) -> [Component] {
    return component.map { [$0] } ?? []
  }
  
  public static func buildArray(_ components: [Component]) -> [Component] {
    return components
  }
  
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }
  
  public static func buildPartialBlock(first: Component) -> [Component] {
    return [first]
  }
  
  public static func buildPartialBlock(accumulated: [Component], next: Component) -> [Component] {
    return accumulated + [next]
  }
}
