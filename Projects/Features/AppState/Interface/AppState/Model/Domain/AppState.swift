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
import Util

public final class AppState: ObservableObject, Injectable {

  // MARK: - Property

  @Published
  public var entranceRouter: EntranceRouter = DIContainer.resolve(
    for: EntranceRouteKey.self
  )

  @Published
  public var chatRouter: ChatRouter = DIContainer.resolve(
    for: ChatRouteKey.self
  )

  public static let instance: AppState = .init()
}
