import SwiftUI
import Onboarding

struct OnboardingContentView: View {

  // MARK: - Property

  let sections: [OnboardingExampleSection] = [
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
      .navigationDestination(for: OnboardingExampleItem.self) { item in
        switch item {
        case .onboardingView: OnboardingView()
        }
      }
      .listStyle(.sidebar)
    }
  }
}


#Preview {
  OnboardingContentView()
}