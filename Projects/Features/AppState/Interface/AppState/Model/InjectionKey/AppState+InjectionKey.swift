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


public enum EntranceRouteKey: InjectionKey {
  public typealias Value = EntranceRouter
}


public enum ChatRouteKey: InjectionKey {
  public typealias Value = ChatRouter
}


public enum MatchingRouteKey: InjectionKey {
  public typealias Value = MatchingRouter
}


public enum MyPageRouteKey: InjectionKey {
  public typealias Value = MyPageRouter
}


public enum HomeRouteKey: InjectionKey {
  public typealias Value = HomeRouter
}
