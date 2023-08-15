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

  func testSetCompletion() async {
    let successString = "SUCCESS"
    var result = ""
    await self.sender.setCompletion { _ in
      result = successString
    }
    await self.sender.completion?(nil)
    XCTAssertEqual(result, successString)
  }

  func testSetData() async {
    let originalData: LaunchCompletionUpdateCount = .init(
      totalCount: 5,
      completedCount: 4
    )

    await self.sender.setData(originalData)

    if let count = await self.sender.data as? LaunchCompletionUpdateCount {
      XCTAssertEqual(count.completedCount, originalData.completedCount)
      XCTAssertEqual(count.totalCount, originalData.totalCount)
    } else {
      XCTFail()
    }
  }

  func testSend() async {
    let originalData: LaunchCompletionUpdateCount = .init(
      totalCount: 10,
      completedCount: 5
    )
    var result: LaunchCompletionSendData?

    await self.sender.setData(originalData)
    await self.sender.setCompletion { data in
      result = data
    }
    await self.sender.send()

    if let count = result as? LaunchCompletionUpdateCount {
      XCTAssertEqual(count.completedCount, originalData.completedCount)
      XCTAssertEqual(count.totalCount, originalData.totalCount)
    } else {
      XCTFail()
    }
  }
}
