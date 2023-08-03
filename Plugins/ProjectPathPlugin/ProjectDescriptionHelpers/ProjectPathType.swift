import Foundation

public enum ProjectPathType {
  case app
  case features(Features)

  public var path: String {
    switch self {
    case .app: return "Projects/App"
    case .features(let feature): return "Projects/Features/" + feature.rawValue
    }
  }
}


// MARK: - Sub Paths

public extension ProjectPathType {

  enum Features: String {
    case base = "Base"
  }
}
