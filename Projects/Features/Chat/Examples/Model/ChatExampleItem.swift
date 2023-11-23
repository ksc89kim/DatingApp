import Foundation

enum ChatExampleItem: String, CaseIterable, Identifiable {
  case demoExample = "데모 예제1"

  // MARK: - Property

  var id: UUID { .init() }
}
