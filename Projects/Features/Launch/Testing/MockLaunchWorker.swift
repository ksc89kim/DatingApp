import Foundation
import LaunchInterface

public final class MockLaunchWorker: LaunchWorkable {

  // MARK: - Property

  public var items: [LaunchWorkable] = []

  public var state: LaunchState = .ready

  let id: UUID = .init()

  var isError: Bool = false

  var workString = ""

  public var sender: LaunchSendable?

  public var completionSender: LaunchCompletionSendable?

  public weak var parent: LaunchWorkable?

  // MARK: - Init

  public init() {
  }

  // MARK: - Method

  public func work() async throws {
    guard !self.isError else {
      throw MockLaunchWorkerError.runError
    }
    if let parent = self.parent as? MockLaunchWorker {
      let parentWorkString = parent.workString
      self.workString = parentWorkString + "\(self.id)"
    } else {
      self.workString = "\(self.id)"
    }
  }
}
