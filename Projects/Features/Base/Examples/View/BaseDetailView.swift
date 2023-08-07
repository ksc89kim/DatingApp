import SwiftUI

struct BaseDetailView: View {
  let name: String

  var body: some View {
    Text(self.name)
  }
}

struct BaseDetailView_Previews: PreviewProvider {
  static var previews: some View {
    BaseDetailView(name: "테스트 예제")
  }
}

