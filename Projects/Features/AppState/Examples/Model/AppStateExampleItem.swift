import Foundation
import AppStateInterface

struct AppStateExampleItem: Identifiable {

  // MARK: - Property

  var id: UUID { .init() }

  let title: String

  let paths: [MainRouterPath]
}
