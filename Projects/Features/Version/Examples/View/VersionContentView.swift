import SwiftUI

struct VersionContentView: View {

  // MARK: - Property

  let sections: [VersionExampleSection] = [
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
      .navigationDestination(for: VersionExampleItem.self) { item in
        switch item {
        case .demoExample: VersionDetailView(name: item.rawValue)
        }
      }
    }
  }
}


#Preview {
  VersionContentView()
}
