import SwiftUI

@main
struct DatingApp: App {

  // MARK: - Property

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }

  // MARK: - Init

  init() {
    AppEnvironment.bootstrap()
  }
}
