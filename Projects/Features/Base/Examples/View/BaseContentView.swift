
import SwiftUI

struct BaseContentView: View {

  // MARK: - Property

  let sections: [BaseExampleSection] = [
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
      .navigationDestination(for: BaseExampleItem.self) { item in
        switch item {
        case .demoExample: BaseDetailView(name: item.rawValue)
        }
      }
      .listStyle(.sidebar)
    }
  }
}

struct BaseContentView_Previews: PreviewProvider {
  public static var previews: some View {
    BaseContentView()
  }
}

