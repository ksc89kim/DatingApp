//
//  InfoPlist+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by kim sunchul on 9/29/24.
//

import ProjectDescription

public extension InfoPlist {
  
  static var app: InfoPlist {
    return .file(path: .relativeToManifest("Support/Info.plist"))
  }
  
  static var examples: InfoPlist {
    return .extendingDefault(with: [
      "UILaunchScreen" : .dictionary([:])
    ])
  }
}
