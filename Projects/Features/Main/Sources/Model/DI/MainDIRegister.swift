//
//  MainDIRegister.swift
//  MainInterface
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import DI
import Core
import MainInterface

public struct MainDIRegister {

  // MARK: - Method

  public static func register() {
    DIContainer.register {
      InjectItem(MainViewKey.self) { MainView() }
    }
  }
}
