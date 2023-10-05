import SwiftUI

struct VersionDetailView: View {
  let name: String

  var body: some View {
    Text(self.name)
  }
}


#Preview {
  VersionDetailView(name: "테스트 예제")
}
