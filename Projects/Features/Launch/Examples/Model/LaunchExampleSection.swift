import Foundation

struct LaunchExampleSection: Identifiable {

  // MARK: - Property

  let id: UUID = .init()

  let name: String

  let items: [LaunchExampleItem]
}


// MARK: - Sections

extension LaunchExampleSection {

  static let examples: LaunchExampleSection = .init(
    name: "런치",
    items: [
      .launchViewForWork,
      .launchViewForAlert,
      .launchViewForNeedUpdate
    ]
  )
}
