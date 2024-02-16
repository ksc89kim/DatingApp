//
//  ProgressMain.swift
//  Core
//
//  Created by kim sunchul on 2/16/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation

public protocol ProgressMain {
  
  // MARK: - Property
  
  var isBottomDisable: Bool { get set }

  // MARK: - Method
  
  func onAppear()

  func onDissapear() async
}


public extension ProgressMain {
  
  func onAppear() { }

  func onDissapear() async { }
}
