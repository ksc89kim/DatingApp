import SwiftUI

struct LaunchDetailView: View {

  // MARK: - Property
  
  let name: String

  // MARK: - Body

  var body: some View {
    Text(self.name)
  }
}

struct LaunchDetailView_Previews: PreviewProvider {
  static var previews: some View {
    LaunchDetailView(name: "테스트 예제")
  }
}

