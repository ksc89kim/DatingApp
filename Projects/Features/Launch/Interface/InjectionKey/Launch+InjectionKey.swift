//
//  Launch+InjectionKey.swift
//  LaunchInterface
//
//  Created by kim sunchul on 2023/09/18.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import DI
import Core

public enum LaunchViewModelKey: InjectionKey {
  public typealias Value = ViewModelType
}

public enum LaunchWorkerBuilderKey: InjectionKey {
  public typealias Value = LaunchWorkerBuildable?
}
