//
//  VIewModelType.swift
//  Launch
//
//  Created by kim sunchul on 2023/09/18.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public protocol ViewModelType: ObservableObject {

  // MARK: - Define

  associatedtype Action

  associatedtype State

  // MARK: - Property

  var state: State { get }

  // MARK: - Method

  func trigger(_ action: Action)

  func trigger(_ action: Action) async
}


extension ViewModelType {

  func trigger(_ action: Action) async {}
}
