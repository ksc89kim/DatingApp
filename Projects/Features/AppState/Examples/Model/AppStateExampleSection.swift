import Foundation
import AppStateInterface

struct AppStateExampleSection: Identifiable {

  // MARK: - Property

  let id: UUID = .init()

  let name: String

  let items: [AppStateExampleItem]
}


// MARK: - Sections

extension AppStateExampleSection {

  static let routers: AppStateExampleSection = .init(
    name: "라우터 Examples",
    items: [
      .init(title: "런치 화면 이동", paths: [.launch]),
      .init(title: "온보딩 화면 이동", paths: [.onboarding]),
      .init(title: "로그인 화면 이동", paths: [.signIn]),
      .init(title: "가입 화면 이동", paths: [.singUp]),
      .init(title: "메인 화면 이동", paths: [.main]),
      .init(title: "런치 + 메인 화면 이동", paths: [.launch, .main]),
      .init(title: "온보딩 + 로그인 화면 이동", paths: [.onboarding, .signIn])
    ]
  )
}
