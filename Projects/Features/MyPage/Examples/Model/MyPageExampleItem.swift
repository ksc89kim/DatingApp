import Foundation

enum MyPageExampleItem: String, CaseIterable, Identifiable {
  case home = "마이페이지 홈"
  case edit = "프로필 편집"
  case setting = "설정"

  // MARK: - Property

  var id: UUID { .init() }
}
