import Foundation
import AppStateTesting

struct AppStateExampleItem: Identifiable {

  // MARK: - Property

  var id: UUID { .init() }

  let title: String

  let paths: [MockRoutePath]
}
