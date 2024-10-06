//
//  SettingDictionary+Templates.swift
//  AppManifests
//
//  Created by kim sunchul on 9/10/24.
//

import ProjectDescription

// MARK: - Project

public extension SettingsDictionary {
  
  static var base: SettingsDictionary {
    return .init()
      .automaticCodeSigning(devTeam: env.teamID)
  }
  
  static var app: SettingsDictionary {
    return self.base
      .marketingVersion(env.marketingVersion)
      .currentProjectVersion(env.buildVersion)
  }
  
  static var feature: SettingsDictionary {
    return self.base
  }
}


// MARK: - Target


public extension SettingsDictionary {
  
  static var appTarget: SettingsDictionary {
    return .init()
      .localizationPrefersStringCatalog(true)
      .localizationExportSupported(true)
      .localizedStringSwiftUISupport(true)
      .swiftEmitLocStrings(true)
  }
  
  static var interfaceTarget: SettingsDictionary {
    return .init()
  }
  
  static var sourcesTarget: SettingsDictionary {
    return .init()
      .localizationPrefersStringCatalog(true)
      .localizationExportSupported(true)
      .localizedStringSwiftUISupport(true)
      .swiftEmitLocStrings(true)
  }
  
  static var testsTarget: SettingsDictionary {
    return .init()
  }
  
  static var testingTarget: SettingsDictionary {
    return .init()
  }
  
  static var exampleTarget: SettingsDictionary {
    return .init()
  }
}

// MARK: - Method

extension SettingsDictionary {
  
  func localizationPrefersStringCatalog(_ isLocalization: Bool) -> SettingsDictionary {
    return self.merging([
      "LOCALIZATION_PREFERS_STRING_CATALOGS": SettingValue(booleanLiteral: isLocalization)
    ])
  }
  
  func localizationExportSupported(_ isLocalization: Bool) -> SettingsDictionary {
    return self.merging([
      "LOCALIZATION_EXPORT_SUPPORTED": SettingValue(booleanLiteral: isLocalization)
    ])
  }
  
  func localizedStringSwiftUISupport(_ isLocalization: Bool) -> SettingsDictionary {
    return self.merging([
      "LOCALIZED_STRING_SWIFTUI_SUPPORT": SettingValue(booleanLiteral: isLocalization)
    ])
  }
  
  func swiftEmitLocStrings(_ isLocalization: Bool) -> SettingsDictionary {
    return self.merging([
      "SWIFT_EMIT_LOC_STRINGS": SettingValue(booleanLiteral: isLocalization)
    ])
  }
}
