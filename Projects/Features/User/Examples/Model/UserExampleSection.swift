import Foundation

struct UserExampleSection: Identifiable {

  // MARK: - Property

  let id: UUID = .init()

  let name: String

  let items: [UserExampleItem]
}


// MARK: - Sections

extension UserExampleSection {

  static let signup: UserExampleSection = .init(
    name: "가입",
    items: [.signup]
  )
  
  static let register: UserExampleSection = .init(
    name: "프로필 등록",
    items: [.register]
  )
}
