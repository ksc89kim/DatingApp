import Foundation

enum MainExampleItem: String, CaseIterable, Identifiable {
  case main = "메인"

  // MARK: - Property

  var id: UUID { .init() }
}
