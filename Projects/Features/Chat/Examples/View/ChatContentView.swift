import SwiftUI
@testable import ChatInterface
@testable import Chat
@testable import ChatTesting
@testable import AppStateInterface
@testable import Core
@testable import DI

struct ChatContentView: View {

  // MARK: - Property

  let sections: [ChatExampleSection] = [
    .examples
  ]

  // MARK: - Body

  var body: some View {
    NavigationStack {
      List {
        ForEach(self.sections) { section in
          Section(section.name) {
            ForEach(section.items) { item in
              NavigationLink(item.rawValue, value: item)
            }
          }
        }
      }
      .navigationTitle("데모")
      .navigationDestination(for: ChatExampleItem.self) { item in
        switch item {
        case .chatList: ChatListView()
        case .chatRoom: ChatRoomView(roomIdx: "123")
        }
      }
      .listStyle(.sidebar)
    }
  }

  // MARK: - Property

  init() {
    AppStateDIRegister.register()
    DIContainer.register {
      InjectItem(ChatListViewModelKey.self) {
        ChatListViewModel(
          listPagination: Pagination(),
          chosenPagination: Pagination()
        )
      }
      InjectItem(ChatRepositoryKey.self) {
        MockChatRepository()
      }
    }
  }
}


#Preview {
  ChatContentView()
}
