//
//  VersionRepository.swift
//  VersionInterface
//
//  Created by kim sunchul on 2023/08/28.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import DI

public protocol VersionRepositoryType: AnyObject, Injectable {

  // MARK: - Method

  func checkVersion() async throws -> CheckVersion?
}
