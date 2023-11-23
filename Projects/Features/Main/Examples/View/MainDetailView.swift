import SwiftUI

struct MainDetailView: View {
  let name: String

  var body: some View {
    Text(self.name)
  }
}

#Preview {
  MainDetailView(name: "테스트 예제")
}
