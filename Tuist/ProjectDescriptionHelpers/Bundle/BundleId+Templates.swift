//
//  BundleId+Templates.swift
//  AppManifests
//
//  Created by kim sunchul on 9/21/24.
//

import Foundation

public extension String {
  
  static var bundleId: String {
    return "com.tronplay.datingapp"
  }
  
  static var appBundleId: String {
    return "$(APP_BUNDLE_ID)"
  }
  
  static func tests(name: String) -> String {
    return bundleId + "." + name + ".tests"
  }
  
  static func sources(name: String) -> String {
    return bundleId + "." + name
  }
  
  static func testing(name: String) -> String {
    return bundleId + "." + name + ".testing"
  }
  
  static func examples(name: String) -> String {
    return bundleId + "." + name + ".examples"
  }
  
  static func interface(name: String) -> String {
    return bundleId + "." + name + ".interface"
  }
}
