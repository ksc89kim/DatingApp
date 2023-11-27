//
//  VersionRepository.swift
//  VersionInterface
//
//  Created by kim sunchul on 2023/08/28.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import VersionInterface
import Core

public final class VersionRepository: VersionRepositoryType {

  // MARK: - Property

  private let networking: Networking<VersionAPI>

  // MARK: - Init

  init(networking: Networking<VersionAPI>) {
    self.networking = networking
  }

  // MARK: - Method

  public func checkVersion() async throws -> CheckVersionEntity? {
    let response = try await self.networking.request(
      CheckVersionResponse.self,
      target: .checkVersion
    ).data

    return response.toEntity()
  }
}
