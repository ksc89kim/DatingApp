import Foundation

enum ChatExampleItem: String, CaseIterable, Identifiable {
  case chatList = "채팅 리스트"
  case chatRoom = "채팅방"

  // MARK: - Property

  var id: UUID { .init() }
}
