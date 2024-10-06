//
//  ProgressMainContainerDelegate.swift
//  Core
//
//  Created by kim sunchul on 2/16/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation

public protocol ProgressMainContainerDelegate: AnyObject {
  
  @MainActor
  func dismiss() async
  
  @MainActor
  func complete() async
  
  @MainActor
  func updateMain(_ main: ProgressMain, value: Double, from: ProgressMainContainer.From)
}
