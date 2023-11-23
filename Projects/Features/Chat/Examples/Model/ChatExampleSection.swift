import Foundation

struct ChatExampleSection: Identifiable {

  // MARK: - Property

  let id: UUID = .init()

  let name: String

  let items: [ChatExampleItem]
}


// MARK: - Sections

extension ChatExampleSection {

  static let examples: ChatExampleSection = .init(
    name: "예시1",
    items: [.demoExample]
  )
}
