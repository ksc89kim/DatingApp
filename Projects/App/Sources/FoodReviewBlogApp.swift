import SwiftUI

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
    AppEnvironment.bootstrap()
  }
}
