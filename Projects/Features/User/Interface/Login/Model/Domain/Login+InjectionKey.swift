//
//  Login+InjectionKey.swift
//  User
//
//  Created by kim sunchul on 11/1/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import DI

public enum LoginLaunchWorkerKey: InjectionKey {
  public typealias Value = Loginable
}
