//
//  Version+InjectionKey.swift
//  VersionInterface
//
//  Created by kim sunchul on 2023/09/12.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import DI
import LaunchInterface

public enum CheckVersionLaunchWorkerKey: InjectionKey {
  public typealias Value = LaunchWorkable
}


public enum VersionRepositoryTypeKey: InjectionKey {
  public typealias Value = VersionRepositoryType
}
