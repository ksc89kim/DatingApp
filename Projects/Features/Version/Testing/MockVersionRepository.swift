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

public final class MockVersionRepository: VersionRepositoryType {

  // MARK: - Property

  var isNeedUpdate: Bool = false

  // MARK: - Method

  public func checkVersion() async throws -> VersionInterface.CheckVersionEntity {
    return .init(
      isNeedUpdate: self.isNeedUpdate,
      message: "업데이트가 필요합니다.",
      linkURL: .init(string: "http://itunes.apple.com/kr/app/")
    )
  }
}
