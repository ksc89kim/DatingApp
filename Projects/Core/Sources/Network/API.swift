//
//  API.swift
//  Core
//
//  Created by kim sunchul on 2023/08/28.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public struct API {

  public enum EndPoint {

    public static var baseURL: String {
      return URLManager().baseURL
    }
  }

  public static let baseHeaders: [String: String] = [
    "Accept": "application/json",
    "Authorization": TokenManager.instance.accessToken() ?? ""
  ]
}
