import Foundation

enum UserExampleItem: String, CaseIterable, Identifiable {
  case signup = "가입 화면"

  // MARK: - Property

  var id: UUID { .init() }
}
