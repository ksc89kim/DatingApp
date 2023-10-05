import SwiftUI

struct AppStateDetailView: View {
  let name: String

  var body: some View {
    Text(self.name)
  }
}


#Preview {
  AppStateDetailView(name: "테스트 예제")
}
