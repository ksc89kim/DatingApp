
import Foundation

struct BaseExampleSection: Identifiable {

  // MARK: - Property

  let id: UUID = .init()

  let name: String

  let items: [BaseExampleItem]
}


// MARK: - Sections

extension BaseExampleSection {

  static let examples: BaseExampleSection = .init(
    name: "예시1",
    items: [.demoExample]
  )
}

