import SwiftUI
import AppStateInterface

@main
struct FoodReviewBlogApp: App {

  // MARK: - Property

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }

  // MARK: - Init

  init() {
    AppState.instance.router.append(
      value: MainRoutePath.launch,
      for: .main
    )

    DIRegister.register()
  }
}
