import Foundation

enum UserExampleItem: String, CaseIterable, Identifiable {
  case signup = "가입 화면"
  case register = "프로필 등록 화면"
  case profile = "프로필 상세 화면"

  // MARK: - Property

  var id: UUID { .init() }
}
