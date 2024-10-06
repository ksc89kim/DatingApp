//
//  NetworkTargetType.swift
//  Core
//
//  Created by kim sunchul on 2023/08/27.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Moya

public protocol NetworkTargetType: TargetType {

  // MARK: - Property

  var method: NetworkMethod { get }

  var task: NetworkTask { get }
}
