import Foundation

enum ChatExampleItem: String, CaseIterable, Identifiable {
  case chatList = "채팅 리스트"

  // MARK: - Property

  var id: UUID { .init() }
}
