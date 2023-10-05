import SwiftUI
import DI
import AppStateInterface
import AppStateTesting

struct AppStateContentView: View {

  // MARK: - Property

  let sections: [AppStateExampleSection] = [
    .routers
  ]

  @EnvironmentObject var appState: AppState

  @State var router: MockRouter = .init()

  // MARK: - Body

  var body: some View {
    NavigationStack(path: self.$router.mock) {
      List {
        ForEach(self.sections) { section in
          Section(section.name) {
            ForEach(section.items) { item in
              Button(item.title) {
                self.router.mock = item.paths
              }
            }
          }
        }
      }
      .navigationTitle("데모")
      .navigationDestination(for: MockRoutePath.self) { item in
        switch item {
        case .launch: AppStateDetailView(name: "런치 페이지")
        case .onboarding: AppStateDetailView(name: "온보딩 페이지")
        case .singUp: AppStateDetailView(name: "가입 화면 페이지")
        case .signIn: AppStateDetailView(name: "로그인 페이지")
        case .main: AppStateDetailView(name: "메인 페이지")
        }
      }
      .listStyle(.sidebar)
    }
  }
}


#Preview {
  DIContainer.register {
    InjectItem(RouteInjectionKey.self) {
      MockRouter()
    }
  }
  return AppStateContentView()
    .environmentObject(AppState.instance)
}
