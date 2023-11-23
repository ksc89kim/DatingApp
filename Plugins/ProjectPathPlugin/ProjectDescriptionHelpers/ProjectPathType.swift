import Foundation

public enum ProjectPathType {
  case app
  case di
  case core
  case util
  case features(Features)

  public var path: String {
    switch self {
    case .app: return "Projects/App"
    case .core: return "Projects/Core"
    case .di: return "Projects/DI"
    case .util: return "Projects/Util"
    case .features(let feature): return "Projects/Features/" + feature.rawValue
    }
  }
}


// MARK: - Sub Paths

public extension ProjectPathType {

  enum Features: String {
    case chat = "Chat"
    case main = "Main"
    case onboarding = "Onboarding"
    case user = "User"
    case appState = "AppState"
    case version = "Version"
    case launch = "Launch"
  }
}
