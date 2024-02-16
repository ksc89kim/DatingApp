//
//  ProgressMainContainer.swift
//  Core
//
//  Created by kim sunchul on 2/16/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation

open class ProgressMainContainer {
  
  // MARK: - Define
  
  public enum From {
    case next
    case previous
    case updateFirstMain
  }
  
  // MARK: - Property
  
  public weak var delegate: ProgressMainContainerDelegate?
  
  private var index: Int = 0
  
  public let mains: [ProgressMain]
  
  public var currentMain: ProgressMain {
    return self.mains[self.index]
  }
  
  // MARK: - Init
  
  public init(
    delegate: ProgressMainContainerDelegate? = nil,
    index: Int,
    mains: [ProgressMain]
  ) {
    self.delegate = delegate
    self.index = index
    self.mains = mains
  }
  
  open func updateFirstMain() async {
    self.index = 0
    await self.updateMain(from: .updateFirstMain)
  }
  
  open func next() async {
    guard self.mains.indices ~= (self.index + 1) else {
      await self.delegate?.complete()
      return
    }
    await self.currentMain.onDissapear()
    self.index += 1
    await self.updateMain(from: .next)
  }
  
  open func previous() async {
    guard self.mains.indices ~= self.index - 1 else {
      await self.delegate?.dismiss()
      return
    }
    
    await self.currentMain.onDissapear()
    self.index -= 1
    await self.updateMain(from: .previous)
  }
  
  open func updateMain(from: From) async {
    guard self.mains.indices ~= self.index else { return }
    let value = Double(self.index + 1) / Double(self.mains.count)
    self.currentMain.onAppear()
    await self.delegate?.updateMain(
      self.currentMain,
      value: value,
      from: from
    )
  }
}
