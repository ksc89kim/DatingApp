import Foundation

struct UserExampleSection: Identifiable {

  // MARK: - Property

  let id: UUID = .init()

  let name: String

  let items: [UserExampleItem]
}


// MARK: - Sections

extension UserExampleSection {

  static let examples: UserExampleSection = .init(
    name: "가입",
    items: [.signup]
  )
}
