import XCTest
@testable import Launch
@testable import LaunchInterface
@testable import LaunchTesting

final class LaunchCompletionSenderTests: XCTestCase {

  // MARK: - Property

  private var sender: LaunchCompletionSender!

  // MARK: - Tests

  override func setUp() {
    super.setUp()

    self.sender = .init()
  }

  /// Sender Completion 호출 확인 테스트
  func testSetCompletion() async {
    let successString = "SUCCESS"
    var result = ""
    await self.sender.setCompletion { _ in
      result = successString
    }
    await self.sender.completion?(nil)
    XCTAssertEqual(result, successString)
  }

  /// Sender 총 갯수가 0인 경우
  func testTotalCountOne() async {
    let totalCount = await self.sender.counter.totalCount
    XCTAssertEqual(totalCount, 1)
  }

  /// Sender 총 갯수 설정 테스트
  func testSetTotalCount() async {
    let result = 10

    await self.sender.setTotalCount(result)

    let totalCount = await self.sender.counter.totalCount
    XCTAssertEqual(totalCount, result)
  }

  /// Sender 완료된 갯수가 0인 경우
  func testCompletedCountEmpty() async {
    let completedCount = await self.sender.counter.completedCount
    XCTAssertEqual(completedCount, 0)
  }

  /// Sender 완료된 갯수 설정 테스트
  func testSetCompletedCount() async {
    let result = 10

    await self.sender.setCompletedCount(result)

    let completedCount = await self.sender.counter.completedCount
    XCTAssertEqual(completedCount, result)
  }

  /// Sender 완료된 갯수 추가하기 테스트
  func testAddCompletedCount() async {
    await self.sender.addCompletedCount()
    let completedCount = await self.sender.counter.completedCount
    XCTAssertEqual(completedCount, 1)
  }

  /// Send 함수 동작 확인 테스트
  func testSend() async {
    var result: LaunchCompletionCounter?
    await self.sender.setCompletion { data in
      result = data
    }
    let completedCount = 10
    let totalCount = 20

    await self.sender.setTotalCount(totalCount)
    await self.sender.setCompletedCount(completedCount)
    await self.sender.send()

    XCTAssertEqual(result?.totalCount, totalCount)
    XCTAssertEqual(result?.completedCount, completedCount + 1)
  }

  /// Send 함수를 Group Task에서 확인 테스트
  func testSendToGroupTask() async {
    let totalCount = 5
    await self.sender.setTotalCount(totalCount)
    var results: [LaunchCompletionCounter] = []
    await self.sender.setCompletion { counter in
      if let counter = counter {
        results.append(counter)
      }
    }

    await withTaskGroup(of: Void.self) { group in
      (1...totalCount).forEach { _ in
        group.addTask {
          await self.sender.send()
        }
      }
    }

    XCTAssertEqual(results.count, totalCount)
    let totalCountAtSender = await self.sender.counter.totalCount
    XCTAssertEqual(totalCountAtSender, totalCount)
    let completedCountAtSender = await self.sender.counter.completedCount
    XCTAssertEqual(completedCountAtSender, totalCount)
    XCTAssertEqual(results[0].totalCount, totalCount)
    XCTAssertEqual(results[1].totalCount, totalCount)
    XCTAssertEqual(results[2].totalCount, totalCount)
    XCTAssertEqual(results[3].totalCount, totalCount)
    XCTAssertEqual(results[4].totalCount, totalCount)
    XCTAssertEqual(results[0].completedCount, 1)
    XCTAssertEqual(results[1].completedCount, 2)
    XCTAssertEqual(results[2].completedCount, 3)
    XCTAssertEqual(results[3].completedCount, 4)
    XCTAssertEqual(results[4].completedCount, 5)
  }
}
