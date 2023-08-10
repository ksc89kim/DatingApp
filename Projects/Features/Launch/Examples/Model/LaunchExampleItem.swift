import Foundation

enum LaunchExampleItem: String, CaseIterable, Identifiable {
  case launchView = "런치 뷰"

  // MARK: - Property

  var id : UUID { .init() }
}
