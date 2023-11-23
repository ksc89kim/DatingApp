import Foundation

struct MainExampleSection: Identifiable {

  // MARK: - Property

  let id: UUID = .init()

  let name: String

  let items: [MainExampleItem]
}


// MARK: - Sections

extension MainExampleSection {

  static let examples: MainExampleSection = .init(
    name: "메인",
    items: [.main]
  )
}
