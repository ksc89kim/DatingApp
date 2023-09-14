import Foundation

enum LaunchExampleItem: String, CaseIterable, Identifiable {
  case launchViewForWork = "런치 뷰 - (네트워크 진행률)"
  case launchViewForAlert = "런치 뷰 - (기본 네트워크 에러 알럿)"
  case launchViewForNeedUpdate = "런치 뷰 - (강제 업데이트)"

  // MARK: - Property

  var id: UUID { .init() }
}
