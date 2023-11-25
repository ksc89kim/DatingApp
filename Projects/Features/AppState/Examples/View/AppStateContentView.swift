import SwiftUI
import DI
import AppStateInterface
@testable import AppStateTesting

struct AppStateContentView: View {

  // MARK: - Property

  let sections: [AppStateExampleSection] = [
    .routers
  ]

  @State
  var router: MockRouter = .init()

  // MARK: - Body

  var body: some View {
    NavigationStack(path: self.$router.paths) {
      List {
        ForEach(self.sections) { section in
          Section(section.name) {
            ForEach(section.items) { item in
              Button(item.title) {
                self.router.set(paths: item.paths)
              }
            }
          }
        }
      }
      .navigationBarTitle("데모", displayMode: .inline)
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
  AppStateContentView()
}
