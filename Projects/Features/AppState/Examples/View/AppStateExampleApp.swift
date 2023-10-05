import SwiftUI
import DI
import AppStateInterface
import AppStateTesting

@main
struct AppStateExampleApp: App {

  // MARK: - Body

  var body: some Scene {
    WindowGroup {
      AppStateContentView()
        .environmentObject(AppState.instance)
    }
  }

  // MARK: - Init
  
  init() {
    DIContainer.register {
      InjectItem(RouteInjectionKey.self) {
        MockRouter()
      }
    }
  }
}
