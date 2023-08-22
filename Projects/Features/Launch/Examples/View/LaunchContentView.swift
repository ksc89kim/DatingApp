import SwiftUI
import Launch

struct LaunchContentView: View {

  // MARK: - Property

  let sections: [LaunchExampleSection] = [
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
      .navigationDestination(for: LaunchExampleItem.self) { item in
        switch item {
        case .launchView: LaunchView()
        }
      }
      .listStyle(.sidebar)
    }
  }
}

struct LaunchContentView_Previews: PreviewProvider {
  public static var previews: some View {
    LaunchContentView()
  }
}
