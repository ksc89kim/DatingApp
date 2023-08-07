import Foundation
import ProjectDescription

public struct ProjectEnvironment {

  // MARK: - Property

  public let name: String

  public let organizationName: String

  public let deploymentTarget: DeploymentTarget

  public let platform: Platform

  public let baseSetting: SettingsDictionary

  public var bundleId: String { self.organizationName + "." + self.name }
}

public let env = ProjectEnvironment(
    name: "FoodReviewBlog",
    organizationName: "com.tronplay",
    deploymentTarget: .iOS(targetVersion: "16.0", devices: [.iphone]),
    platform: .iOS,
    baseSetting: [:]
)
