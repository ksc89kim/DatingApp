//
//  AppState.swift
//  Core
//
//  Created by kim sunchul on 2023/10/03.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import DI

public enum AppStateKey: InjectionKey {
  public typealias Value = AppState
}


public final class AppState: ObservableObject, Injectable {

  // MARK: - Property

  @Published public var router: Router = .init()

  public static let instance: AppState = .init()
}
