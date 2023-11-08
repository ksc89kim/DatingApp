import SwiftUI

struct OnboardingDetailView: View {
  let name: String

  var body: some View {
    Text(self.name)
  }
}

#Preview {
  OnboardingDetailView(name: "테스트 예제")
}
