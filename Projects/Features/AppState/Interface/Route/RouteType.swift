//
//  RouteType.swift
//  AppStateInterface
//
//  Created by kim sunchul on 2023/10/05.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import DI

public enum RouteInjectionKey: InjectionKey {
  public typealias Value = RouteType
}


public protocol RouteType: Injectable {

  var main: [MainRoutePath] { get set }
  
  mutating func append(value: Any, for key: RouteKeyType)

  mutating func remove(value: Any, for key: RouteKeyType)
}


public extension RouteType {

  func append<T>(
    paths: inout [T],
    value: Any
  ) {
    guard let value = value as? T else { return }
    paths.append(value)
  }

  func remove<T: Equatable>(
    paths: inout [T],
    value: Any
  ) {
    guard let value = value as? T else { return }
    paths.removeAll { router in router == value }
  }
}
