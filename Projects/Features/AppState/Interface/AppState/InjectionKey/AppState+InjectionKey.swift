//
//  AppState+InjectionKey.swift
//  AppStateInterface
//
//  Created by kim sunchul on 11/8/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import DI

public enum AppStateKey: InjectionKey {
  public typealias Value = AppState
}


public enum RouteInjectionKey: InjectionKey {
  public typealias Value = RouteType?
}
