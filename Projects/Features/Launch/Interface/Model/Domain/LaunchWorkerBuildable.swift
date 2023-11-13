//
//  LaunchWorkerBuildable.swift
//  LaunchInterface
//
//  Created by kim sunchul on 2023/09/12.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import DI

public protocol LaunchWorkerBuildable: Injectable {

  // MARK: - Method

  func build() async -> LaunchWorkable
}
