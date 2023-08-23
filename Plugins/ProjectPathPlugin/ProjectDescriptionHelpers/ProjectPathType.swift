import Foundation

public enum ProjectPathType {
  case app
  case di
  case core
  case features(Features)

  public var path: String {
    switch self {
    case .app: return "Projects/App"
    case .core: return "Projects/Core"
    case .di: return "Projects/DI"
    case .features(let feature): return "Projects/Features/" + feature.rawValue
    }
  }
}


// MARK: - Sub Paths

public extension ProjectPathType {

  enum Features: String {
    case launch = "Launch"
  }
}
