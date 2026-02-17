//
//  AppStateDIRegister.swift
//  AppStateInterface
//
//  Created by kim sunchul on 11/23/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import DI

public struct AppStateDIRegister {

  // MARK: - Method
  
  public static func register() {
    DIContainer.register {
      InjectItem(AppStateKey.self) { AppState.instance }
      InjectItem(EntranceRouteKey.self) { EntranceRouter() }
      InjectItem(ChatRouteKey.self) { ChatRouter() }
      InjectItem(MatchingRouteKey.self) { MatchingRouter() }
    }
  }
}
