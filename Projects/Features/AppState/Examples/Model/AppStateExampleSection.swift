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
    name: "Main Router Examples",
    items: [
      .init(title: "런치 페이지 이동 - Stack 1", paths: [.launch]),
      .init(title: "런치 페이지 이동 - Stack 2", paths: [.launch, .launch])
    ]
  )
}
