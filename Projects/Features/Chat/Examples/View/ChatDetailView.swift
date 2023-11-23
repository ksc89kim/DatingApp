import SwiftUI

struct ChatDetailView: View {
  let name: String

  var body: some View {
    Text(self.name)
  }
}

#Preview {
  ChatDetailView(name: "테스트 예제")
}
