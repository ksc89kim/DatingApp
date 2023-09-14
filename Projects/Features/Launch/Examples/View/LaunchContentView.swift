import SwiftUI
import Launch
import LaunchTesting
import VersionInterface

struct LaunchContentView: View {

  // MARK: - Property

  let sections: [LaunchExampleSection] = [
    .examples
  ]

  // MARK: - Body

  var body: some View {
    NavigationView {
      List {
        ForEach(self.sections) { section in
          Section(section.name) {
            ForEach(section.items) { item in
              self.makeLaunchView(item: item)
            }
          }
        }
      }
      .navigationTitle("데모")
      .listStyle(.sidebar)
    }
  }

  func makeLaunchView(item: LaunchExampleItem) -> NavigationLink<Text, some View> {
    let builder: MockLaunchWorkerBuilder
    switch item {
    case .launchViewForWork:
      builder = .init(
        isSleep: true
      )
    case .launchViewForAlert:
      builder = .init(
        error: MockLaunchWorkerError.runError
      )
    case .launchViewForNeedUpdate:
      let entity: CheckVersionEntity = .init(
        isNeedUpdate: true,
        message: "업데이트가 필요합니다.",
        linkURL: .init(string: "https://www.naver.com")!
      )
      builder = .init(
        error: CheckVersionLaunchWorkError.needUpdate(entity)
      )
    }
    return NavigationLink(item.rawValue) {
      LaunchView(bulider: builder)
    }
  }
}


struct LaunchContentView_Previews: PreviewProvider {

  public static var previews: some View {
    LaunchContentView()
  }
}
