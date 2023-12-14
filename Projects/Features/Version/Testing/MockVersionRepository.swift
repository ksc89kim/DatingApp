//
//  MockVersionRepository.swift
//  VersionInterface
//
//  Created by kim sunchul on 2023/08/31.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import VersionInterface
import Core

final class MockVersionRepository: VersionRepositoryType {

  // MARK: - Property

  var isForceUpdate: Bool = false

  // MARK: - Method

  func checkVersion() async throws -> CheckVersion? {
    return .init(
      isForceUpdate: self.isForceUpdate,
      message: "업데이트가 필요합니다.",
      linkURL: .init(string: "http://itunes.apple.com/kr/app/")!
    )
  }
}
