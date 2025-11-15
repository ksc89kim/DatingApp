//
//  Chip.swift
//  Util
//
//  Created by kim sunchul on 2/17/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation
import SwiftUI

public struct Chip: Hashable, Identifiable {
  
  // MARK: - Property
  
  public let id: UUID = .init()
  
  public let key: String?
  
  public let title: LocalizedStringResource
  
  // MARK: - Init
  
  public init(key: String, title: LocalizedStringResource) {
    self.key = key
    self.title = title
  }
  
  // MARK: - Method
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(self.title.stringValue)
    hasher.combine(self.key)
    hasher.combine(self.id)
  }
}
