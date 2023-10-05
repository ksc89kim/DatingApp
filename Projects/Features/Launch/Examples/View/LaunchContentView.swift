import SwiftUI
import DI
import LaunchInterface
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
    NavigationStack {
      List {
        ForEach(self.sections) { section in
          Section(section.name) {
            ForEach(section.items) { item in
              NavigationLink(item.rawValue, value: item)
            }
          }
        }
      }
      .navigationTitle("데모")
      .navigationDestination(for: LaunchExampleItem.self) { item in
        self.makeLaunchView(item: item)
      }
    }
  }

  func makeLaunchView(item: LaunchExampleItem) -> LaunchView {
    DIContainer.register {
      InjectItem(LaunchViewModelKey.self) {
        let viewModel = LaunchViewModel()
        viewModel.limitRetryCount = 3
        return viewModel
      }
    }
    switch item {
    case .launchViewForWork:
      DIContainer.register {
        InjectItem(LaunchWorkerBuilderKey.self) {
          return MockLaunchWorkerBuilder(
            isSleep: true
          )
        }
      }
    case .launchViewForAlert:
      DIContainer.register {
        InjectItem(LaunchWorkerBuilderKey.self) {
          return MockLaunchWorkerBuilder(
            error: MockLaunchWorkerError.runError
          )
        }
      }
    case .launchViewForNeedUpdate:
      DIContainer.register {
        InjectItem(LaunchWorkerBuilderKey.self) {
          let entity: CheckVersionEntity = .init(
            isForceUpdate: false,
            message: "업데이트가 필요합니다.",
            linkURL: .init(string: "https://www.naver.com")!
          )
          return MockLaunchWorkerBuilder(
            error: CheckVersionLaunchWorkError.forceUpdate(entity)
          )
        }
      }
    }
    return LaunchView()
  }
}


#Preview {
  LaunchContentView()
}
