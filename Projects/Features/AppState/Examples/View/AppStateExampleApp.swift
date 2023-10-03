import SwiftUI
import AppStateInterface

@main
struct AppStateExampleApp: App {

  // MARK: - Body

  var body: some Scene {
    WindowGroup {
      AppStateContentView()
        .environmentObject(AppState.instance)
    }
  }
}
