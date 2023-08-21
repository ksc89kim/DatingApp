import Foundation
import LaunchInterface

final class MockLaunchWorker: LaunchWorkable {

  // MARK: - Property

  var items: [LaunchWorkable] = []

  var state: LaunchState = .ready

  let id: UUID = .init()

  var isError: Bool = false

  var workString = ""

  var sender: LaunchSendable?

  var completionSender: LaunchCompletionSendable?

  weak var parent: LaunchWorkable?

  // MARK: - Method

  func work() async throws {
    guard !self.isError else {
      throw MockLaunchWorkerError.runError
    }
    print("## \(self.id)")
    if let parent = self.parent as? MockLaunchWorker {
      let parentWorkString = parent.workString
      self.workString = parentWorkString + "\(self.id)"
    } else {
      self.workString = "\(self.id)"
    }
  }
}
