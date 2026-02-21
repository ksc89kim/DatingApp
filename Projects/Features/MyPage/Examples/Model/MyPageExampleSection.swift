import Foundation

struct MyPageExampleSection: Identifiable {

  // MARK: - Property

  let id: UUID = .init()

  let name: String

  let items: [MyPageExampleItem]
}


// MARK: - Sections

extension MyPageExampleSection {

  static let examples: MyPageExampleSection = .init(
    name: "마이페이지",
    items: MyPageExampleItem.allCases
  )
}
