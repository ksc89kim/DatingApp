//
//  MicroFeaturesType.swift
//  MicroFeaturesPlugin
//
//  Created by kim sunchul on 2023/07/26.
//

import Foundation

public struct MicroFeaturesType: OptionSet {

  // MARK: - Property

  public let rawValue: Int

  public static let source: MicroFeaturesType = .init(rawValue: 1 << 0)

  public static let interface: MicroFeaturesType = .init(rawValue: 1 << 1)

  public static let testing: MicroFeaturesType = .init(rawValue: 1 << 2)

  public static let tests: MicroFeaturesType = .init(rawValue: 1 << 3)

  public static let examples: MicroFeaturesType = .init(rawValue: 1 << 4)

  public static let all: MicroFeaturesType = [
    .examples,
    .interface,
    .source,
    .testing,
    .tests
  ]


  // MARK: - Init

  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
}
