import Foundation

public enum ProjectType {
  case app
  case di
  case core
  case util
  case base
  case features(Features)
  
  public var path: String {
    switch self {
    case .app: return "Projects/App"
    case .core: return "Projects/Core"
    case .di: return "Projects/DI"
    case .util: return "Projects/Util"
    case .base: return "Projects/Base"
    case .features(let feature): return "Projects/Features/" + feature.rawValue
    }
  }
  
  public var name: String {
    switch self {
    case .app: return "APP"
    case .core: return "Core"
    case .di: return "DI"
    case .util: return "Util"
    case .base: return "Base"
    case .features(let feature): return feature.rawValue
    }
  }
}


// MARK: - Features

public extension ProjectType {
  
  enum Features: String {
    case chat = "Chat"
    case matching = "Matching"
    case main = "Main"
    case onboarding = "Onboarding"
    case user = "User"
    case appState = "AppState"
    case version = "Version"
    case launch = "Launch"
    case myPage = "MyPage"
  }
}
