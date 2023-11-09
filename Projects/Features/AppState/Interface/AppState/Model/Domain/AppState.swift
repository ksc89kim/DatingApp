//
//  AppState.swift
//  AppState
//
//  Created by kim sunchul on 2023/10/03.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import DI
import UserInterface


public final class AppState: ObservableObject, Injectable {

  // MARK: - Property

  @Published 
  public var router: RouteType = DIContainer.resolve(
    for: RouteInjectionKey.self
  )

  public static let instance: AppState = .init()
}
