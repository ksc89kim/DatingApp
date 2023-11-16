//
//  DiContainer+SwiftUI.swift
//  DI
//
//  Created by kim sunchul on 2023/10/04.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI

extension AnyView: Injectable {
}


public extension DIContainer {

  static func resolveView(for type: Any.Type?) -> AnyView {
    let name = self.name(for: type) ?? ""
    guard let view = self.instance.items[name]?.resolve() as? (any View) else {
      fatalError("Dependency \(name) not resolved")
    }
    return AnyView(view)
  }
}
