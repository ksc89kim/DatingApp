import SwiftUI

struct LaunchDetailView: View {
  let name: String

  var body: some View {
    Text(self.name)
  }
}

struct LaunchDetailView_Previews: PreviewProvider {
  static var previews: some View {
    LaunchDetailView(name: "테스트 예제")
  }
}

