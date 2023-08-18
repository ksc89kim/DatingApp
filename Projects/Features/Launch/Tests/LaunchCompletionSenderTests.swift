import XCTest
@testable import LaunchInterface
@testable import LaunchTesting

final class LaunchCompletionSenderTests: XCTestCase {

  // MARK: - Property

  var sender: LaunchCompletionSender!

  // MARK: - Tests

  override func setUp() {
    super.setUp()

    self.sender = .init()
  }

  /// Sender Completion 호출 확인
  func testSetCompletion() async {
    let successString = "SUCCESS"
    var result = ""
    await self.sender.setCompletion { _ in
      result = successString
    }
    await self.sender.completion?(nil)
    XCTAssertEqual(result, successString)
  }

  /// Send 함수 동작 확인
  func testSend() async {
    let originalData: LaunchCompletionCount = .init(
      totalCount: 10,
      completedCount: 5
    )
    var result: LaunchSendDataType?
    await self.sender.setCompletion { data in
      result = data
    }

    await self.sender.send(originalData)

    if let compareData = result as? LaunchCompletionCount {
      XCTAssertEqual(compareData, originalData)
    } else {
      XCTFail()
    }
  }

  /// Send 함수를 Group Task에서 확인
  func testSendToGroupTask() async {
    let maxCount: Int = 5
    var datas: [LaunchCompletionCount] = (1...maxCount).map { index in
      return .init(totalCount: maxCount, completedCount: index)
    }

    var count: Int = 0
    await self.sender.setCompletion { data in
      guard let data = data as? LaunchCompletionCount else { return }
      if datas.contains(data) {
        count += 1

        datas.removeAll { compareData in
          compareData == data
        }
      }
    }

    await withTaskGroup(of: Void.self) { group in
      datas.forEach { data in
        group.addTask {
          await self.sender.send(data)
        }
      }
    }

    XCTAssertEqual(count, maxCount)
    XCTAssertTrue(datas.isEmpty)
  }
}
