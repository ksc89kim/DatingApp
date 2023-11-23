import SwiftUI
import Main

struct MainContentView: View {

  // MARK: - Property

  let sections: [MainExampleSection] = [
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
      .navigationDestination(for: MainExampleItem.self) { item in
        switch item {
        case .main: MainView()
        }
      }
      .listStyle(.sidebar)
    }
  }
}


#Preview {
  MainContentView()
}
