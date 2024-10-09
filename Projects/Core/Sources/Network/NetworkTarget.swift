//
//  NetworkTargetType.swift
//  Core
//
//  Created by kim sunchul on 2023/08/27.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import Moya

public protocol NetworkTargetType {
  var baseURL: URL { get }
  var path: String { get }
  var method: NetworkMethod { get }
  var task: NetworkTask { get }
  var sampleData: Data { get }
  var validationType: ValidationType { get }
  var headers: [String: String]? { get }
}


public extension NetworkTargetType {
  
  var validationType: ValidationType {
    return .none
  }
  
  var headers: [String: String]? {
    return nil
  }
  
  var sampleData: Data {
    return .init()
  }
}


extension NetworkTargetType {
  
  var asMoya: MoyaTarget {
    return MoyaTarget(
      baseURL: self.baseURL,
      path: self.path,
      method: self.method.asMoya,
      task: self.task.asMoya,
      sampleData: self.sampleData,
      validationType: self.validationType,
      headers: self.headers
    )
  }
}
