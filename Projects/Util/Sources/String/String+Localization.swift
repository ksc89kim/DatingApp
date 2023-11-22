//
//  String+Localization.swift
//  Util
//
//  Created by kim sunchul on 11/21/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

extension LocalizedStringResource {

  static let confirm = LocalizedStringResource(
    "확인",
    defaultValue: "확인",
    bundle: .atURL(UtilResources.bundle.bundleURL)
  )

  static let cancel = LocalizedStringResource(
    "취소",
    defaultValue: "취소",
    bundle: .atURL(UtilResources.bundle.bundleURL)
  )
}


public extension LocalizedStringResource {

  var stringValue: String {
    return String(localized: self)
  }
}


public extension String {

  static var confirm: String {
    return LocalizedStringResource.confirm.stringValue
  }

  static var cancel: String {
    return LocalizedStringResource.cancel.stringValue
  }
}
