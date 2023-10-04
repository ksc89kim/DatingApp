import SwiftUI
import AppStateInterface

struct AppStateContentView: View {

  // MARK: - Property

  let sections: [AppStateExampleSection] = [
    .routers
  ]

  @EnvironmentObject var appState: AppState

  // MARK: - Body

  var body: some View {
    NavigationStack(path: self.$appState.router.main) {
      List {
        ForEach(self.sections) { section in
          Section(section.name) {
            ForEach(section.items) { item in
              Button(item.title) {
                self.appState.router.main = item.paths
              }
            }
          }
        }
      }
      .navigationTitle("데모")
      .navigationDestination(for: MainRoutePath.self) { item in
        switch item {
        case .launch: AppStateDetailView(name: "런치 페이지")
        }
      }
      .listStyle(.sidebar)
    }
  }
}

struct AppStateContentView_Previews: PreviewProvider {
  public static var previews: some View {
    AppStateContentView()
      .environmentObject(AppState.instance)
  }
}
