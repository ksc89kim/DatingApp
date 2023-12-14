//
//  CheckVersionLaunchWorkError.swift
//  VersionInterface
//
//  Created by kim sunchul on 2023/08/28.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public enum CheckVersionLaunchWorkError: LocalizedError {
  case emptyEntity
  case forceUpdate(CheckVersion)
}
