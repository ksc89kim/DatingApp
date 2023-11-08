import Foundation

struct OnboardingExampleSection: Identifiable {

  // MARK: - Property

  let id: UUID = .init()

  let name: String

  let items: [OnboardingExampleItem]
}


// MARK: - Sections

extension OnboardingExampleSection {

  static let examples: OnboardingExampleSection = .init(
    name: "온보딩 화면",
    items: [.onboardingView]
  )
}
