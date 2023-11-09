import SwiftUI

struct UserContentView: View {

  // MARK: - Property

  let sections: [UserExampleSection] = [
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
      .navigationBarTitle("데모", displayMode: .inline)
      .navigationDestination(for: UserExampleItem.self) { item in
        switch item {
        case .demoExample: UserDetailView(name: item.rawValue)
        }
      }
      .listStyle(.sidebar)
    }
  }
}


#Preview {
  UserContentView()
}
