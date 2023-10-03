import SwiftUI

struct AppStateDetailView: View {
  let name: String

  var body: some View {
    Text(self.name)
  }
}

struct AppStateDetailView_Previews: PreviewProvider {

  static var previews: some View {
    AppStateDetailView(name: "테스트 예제")
  }
}
