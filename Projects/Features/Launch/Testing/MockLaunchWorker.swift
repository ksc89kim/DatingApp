import Foundation
import LaunchInterface

final class MockLaunchWorker: LaunchWorkable {

  // MARK: - Property

  var items: [LaunchWorkable] = []

  var state: LaunchState = .ready

  let id: UUID = .init()

  var isError: Bool = false

  var workString = ""

  weak var parent: MockLaunchWorker?

  // MARK: - Method

  func work() async throws {
    guard !self.isError else {
      throw MockLaunchWorkerError.runError
    }

    let parentWorkString = self.parent?.workString ?? ""
    self.workString = parentWorkString + "\(self.id)"
  }
}
