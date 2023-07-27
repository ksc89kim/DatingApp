//
//  Target+MicroFeaturesType.swift
//  MicroFeaturesPlugin
//
//  Created by kim sunchul on 2023/07/26.
//

import ProjectDescription

public extension Target {
  
  static func make(
    name: String,
    type: MicroFeaturesType,
    baseBuilder: Target.Builder? = nil
  ) -> Self {
    let builder: Target.Builder = .init()
    if let baseBuilder = baseBuilder {
      builder.builder(baseBuilder)
    }
    builder.sources(.path(type: type))

    if type.contains(.interface) {
      builder.name(name + "Interface")
        .product(.framework)
    } else if type.contains(.source) {
      builder.name(name)
        .product(.framework)
    } else if type.contains(.testing) {
      builder.name(name + "Testing")
        .product(.framework)
    } else if type.contains(.tests) {
      builder.name(name + "Tests")
        .product(.unitTests)
    } else if type.contains(.examples) {
      builder.name(name + "Examples")
        .product(.app)
    }
    return builder.build()
  }

  static func make(
    name: String,
    type: MicroFeaturesType,
    baseBuilder: Target.Builder? = nil
  ) -> [Self] {
    var targets: [Target] = []
    if type.contains(.interface) {
      targets.append(
        .make(
          name: name,
          type: type,
          baseBuilder: baseBuilder
        )
      )
    }
    
    if type.contains(.source) {
      targets.append(
        .make(
          name: name,
          type: type,
          baseBuilder: baseBuilder
        )
      )
    }
    
    if type.contains(.testing) {
      targets.append(
        .make(
          name: name,
          type: type,
          baseBuilder: baseBuilder
        )
      )
    }
    
    if type.contains(.tests) {
      targets.append(
        .make(
          name: name,
          type: type,
          baseBuilder: baseBuilder
        )
      )
    }
    
    if type.contains(.examples) {
      targets.append(
        .make(
          name: name,
          type: type,
          baseBuilder: baseBuilder
        )
      )
    }
    
    return targets
  }
}
