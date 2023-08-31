//
//  NetworkResponse.swift
//  Core
//
//  Created by kim sunchul on 2023/08/31.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public struct NetworkResponse<T: Codable>: Codable {

  // MARK: - Property

  public let code: Int

  public let message: String?

  public let data: T
}
