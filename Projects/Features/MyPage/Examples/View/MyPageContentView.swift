import SwiftUI
@testable import MyPageInterface
@testable import MyPage
@testable import MyPageTesting
@testable import AppStateInterface
@testable import DI

struct MyPageContentView: View {

  // MARK: - Property

  let sections: [MyPageExampleSection] = [
    .examples
  ]

  @State
  private var isShowingHome: Bool = false

  // MARK: - Body

  var body: some View {
    NavigationStack {
      List {
        ForEach(self.sections) { section in
          Section(section.name) {
            ForEach(section.items) { item in
              switch item {
              case .home:
                Button(item.rawValue) {
                  self.isShowingHome = true
                }
                .foregroundStyle(Color(.label))
              default:
                NavigationLink(item.rawValue, value: item)
              }
            }
          }
        }
      }
      .navigationTitle("데모")
      .navigationDestination(for: MyPageExampleItem.self) { item in
        switch item {
        case .home:
          EmptyView()
        case .edit:
          MyPageEditView(
            viewModel: MyPageEditViewModel(
              input: .init(
                nickname: "테스트유저",
                introduce: "안녕하세요!",
                height: "170",
                job: "개발자",
                gameGenre: ["RPG"],
                mbti: "INFJ"
              )
            )
          )
        case .setting:
          MyPageSettingView()
        }
      }
      .toolbarTitleDisplayMode(.inline)
      .listStyle(.sidebar)
    }
    .fullScreenCover(isPresented: self.$isShowingHome) {
      MyPageHomeView()
    }
  }

  // MARK: - Init

  init() {
    AppStateDIRegister.register()
    DIContainer.register {
      InjectItem(MyPageRepositoryTypeKey.self) {
        MockMyPageRepository()
      }
      InjectItem(MyPageSettingRepositoryTypeKey.self) {
        MockMyPageSettingRepository()
      }
      InjectItem(MyPageViewModelKey.self) {
        MyPageViewModel()
      }
      InjectItem(MyPageSettingViewModelKey.self) {
        MyPageSettingViewModel()
      }
    }
  }
}


#Preview {
  MyPageContentView()
}
