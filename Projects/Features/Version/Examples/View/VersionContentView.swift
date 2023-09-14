import SwiftUI

struct VersionContentView: View {

  // MARK: - Property

  let sections: [VersionExampleSection] = [
    .examples
  ]

  // MARK: - Body

  var body: some View {
    NavigationView {
      List {
        ForEach(self.sections) { section in
          Section(section.name) {
            ForEach(section.items) { item in
              NavigationLink(item.rawValue) {
                VersionDetailView(name: item.rawValue)
              }
            }
          }
        }
      }
      .navigationTitle("데모")
      .listStyle(.sidebar)
    }
  }
}

struct VersionContentView_Previews: PreviewProvider {

  public static var previews: some View {
    VersionContentView()
  }
}
