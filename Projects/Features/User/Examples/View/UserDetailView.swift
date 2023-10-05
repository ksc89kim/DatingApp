import SwiftUI

struct UserDetailView: View {
  let name: String

  var body: some View {
    Text(self.name)
  }
}

#Preview {
  UserDetailView(name: "테스트 예제")
}
