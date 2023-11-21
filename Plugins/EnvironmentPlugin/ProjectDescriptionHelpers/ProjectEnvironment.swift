import Foundation
import ProjectDescription

public struct ProjectEnvironment {

  // MARK: - Property

  public let name: String

  public let organizationName: String

  public let options: Project.Options

  public let deploymentTarget: DeploymentTarget

  public let platform: Platform

  public let baseSetting: SettingsDictionary

  public var bundleId: String { self.organizationName + "." + self.name }
}

public let env = ProjectEnvironment(
    name: "DatingApp",
    organizationName: "com.tronplay",
    options: .options(defaultKnownRegions: ["kor", "en"], developmentRegion: "kor"),
    deploymentTarget: .iOS(targetVersion: "17.0", devices: [.iphone]),
    platform: .iOS,
    baseSetting: [
      "LOCALIZATION_PREFERS_STRING_CATALOGS": "YES",
      "LOCALIZATION_EXPORT_SUPPORTED": "YES",
      "LOCALIZED_STRING_SWIFTUI_SUPPORT": "YES",
      "SWIFT_EMIT_LOC_STRINGS": "YES"
    ]
)
