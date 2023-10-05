//
//  AppEnvironment.swift
//  FoodReviewBlog
//
//  Created by kim sunchul on 2023/10/04.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import AppStateInterface

struct AppEnvironment {

  // MARK: - Method

  static func bootstrap() {

    let diRegister: DIRegister = .init()
    diRegister.register()

    AppState.instance.router.append(
      value: MainRoutePath.launch,
      for: RouteKey.main
    )
  }
}
