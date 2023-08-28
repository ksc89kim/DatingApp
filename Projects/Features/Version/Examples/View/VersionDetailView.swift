import SwiftUI

struct VersionDetailView: View {
  let name: String

  var body: some View {
    Text(self.name)
  }
}

struct VersionDetailView_Previews: PreviewProvider {

  static var previews: some View {
    VersionDetailView(name: "테스트 예제")
  }
}
