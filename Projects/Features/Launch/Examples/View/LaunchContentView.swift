import SwiftUI
@testable import DI
@testable import Core
@testable import LaunchInterface
@testable import Launch
@testable import LaunchTesting
@testable import VersionInterface
@testable import AppStateInterface

struct LaunchContentView: View {

  // MARK: - Property

  let sections: [LaunchExampleSection] = [
    .examples
  ]

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
      .navigationBarTitle("데모", displayMode: .inline)
      .navigationDestination(for: LaunchExampleItem.self) { item in
        self.makeLaunchView(item: item)
      }
    }
  }

  // MARK: - Init

  init() {
    AppStateDIRegister.register()
    DIContainer.register {
      InjectItem(LaunchViewModelKey.self) {
        let viewModel = LaunchViewModel(tokenManager: MockTokenManager())
        viewModel.limitRetryCount = 3
        return viewModel
      }
    }
  }

  // MARK: - Method

  func makeLaunchView(item: LaunchExampleItem) -> LaunchView {

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
          let entity: CheckVersion = .init(
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
