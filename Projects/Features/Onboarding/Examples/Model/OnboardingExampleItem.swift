import Foundation

enum OnboardingExampleItem: String, CaseIterable, Identifiable {
  case onboardingView = "온보딩"

  // MARK: - Property

  var id: UUID { .init() }
}
