//
//  String+Localization.swift
//  Util
//
//  Created by kim sunchul on 11/21/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public extension LocalizedStringResource {

  var stringValue: String {
    return String(localized: self)
  }
}
