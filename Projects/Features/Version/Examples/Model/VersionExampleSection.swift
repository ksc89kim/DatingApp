import Foundation

struct VersionExampleSection: Identifiable {

  // MARK: - Property

  let id: UUID = .init()

  let name: String

  let items: [VersionExampleItem]
}


// MARK: - Sections

extension VersionExampleSection {

  static let examples: VersionExampleSection = .init(
    name: "예시1",
    items: [.demoExample]
  )
}
