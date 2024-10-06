import Foundation
import ProjectDescription

public struct ProjectEnvironment {
  
  // MARK: - Property
  
  public let name: String
  
  public let teamID: String
  
  public let marketingVersion: String
  
  public let buildVersion: String
  
  public let organizationName: String
  
  public let defaultKnownRegions: [String]
  
  public let developmentRegion: String
  
  public let deploymentTarget: DeploymentTargets
  
  public let destinations: Destinations
}


public let env = ProjectEnvironment(
  name: "DatingApp",
  teamID: "tronplay",
  marketingVersion: "1.0.0",
  buildVersion: "1",
  organizationName: "Tronplay",
  defaultKnownRegions: ["kor", "en"],
  developmentRegion: "kor",
  deploymentTarget: .iOS("17.0"),
  destinations: .iOS
)
