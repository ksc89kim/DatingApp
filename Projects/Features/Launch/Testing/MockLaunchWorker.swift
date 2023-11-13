import Foundation
import LaunchInterface

final class MockLaunchWorker: LaunchWorkable {

  // MARK: - Property

  var items: [LaunchWorkable] = []

  var state: LaunchWorkerState = .ready

  let id: UUID = .init()

  var error: Error?

  var isSleep: Bool = false

  var workString = ""

  public var sender: LaunchSendable?

  public var completionSender: LaunchCompletionSender?

  public weak var parent: LaunchWorkable?

  // MARK: - Init

  public init() {
  }

  // MARK: - Method

  public func work() async throws {
    if let error = self.error {
      self.state = .ready
      throw error
    }

    if self.isSleep {
      try await Task.sleep(nanoseconds: 2000000000)
    }
    
    if let parent = self.parent as? MockLaunchWorker {
      let parentWorkString = parent.workString
      self.workString = parentWorkString + "\(self.id)"
    } else {
      self.workString = "\(self.id)"
    }
  }
}
