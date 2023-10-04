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

    AppState.instance.router.append(
      value: MainRoutePath.launch,
      for: .main
    )

    let diRegister: DIRegister = .init()
    diRegister.register()
  }
}
