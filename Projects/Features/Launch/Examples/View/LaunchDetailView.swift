import SwiftUI

struct LaunchDetailView: View {

  // MARK: - Property
  
  let name: String

  // MARK: - Body

  var body: some View {
    Text(self.name)
  }
}


#Preview {
  LaunchDetailView(name: "테스트 예제")
}
