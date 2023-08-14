import Foundation
import LaunchInterface

final class MockLaunchWorker: LaunchWorkable {

  // MARK: - Property

  var items: [LaunchWorkable] = []

  var state: LaunchState = .ready

  // MARK: - Method

  func work() async throws {
  }
}
