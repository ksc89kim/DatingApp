import SwiftUI
@testable import Chat
@testable import AppStateInterface

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
        }
      }
      .listStyle(.sidebar)
    }
  }

  // MARK: - Property

  init() {
    AppStateDIRegister.register()
  }
}


#Preview {
  ChatContentView()
}
