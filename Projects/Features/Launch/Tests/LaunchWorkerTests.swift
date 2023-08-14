import XCTest
@testable import LaunchInterface
@testable import LaunchTesting

final class LaunchWorkerTests: XCTestCase {

  func testTotalSizeAtWorker() throws {
    let rootWorker: LaunchWorkable = MockLaunchWorker()

    XCTAssertEqual(rootWorker.totalSize, 1)
    rootWorker.push(item: MockLaunchWorker())
    rootWorker.push(item: MockLaunchWorker())
    rootWorker.push(item: MockLaunchWorker())
    XCTAssertEqual(rootWorker.totalSize, 4)
    rootWorker.push(item: MockLaunchWorker())
    XCTAssertEqual(rootWorker.totalSize, 5)
    XCTAssertNotEqual(rootWorker.totalSize, 3)

    let chainFirstItem: LaunchWorkable = MockLaunchWorker()
    rootWorker.push(item: chainFirstItem)
    XCTAssertEqual(rootWorker.totalSize, 6)
    chainFirstItem.push(item: MockLaunchWorker())
    XCTAssertEqual(rootWorker.totalSize, 7)
    chainFirstItem.push(item: MockLaunchWorker())
    XCTAssertEqual(rootWorker.totalSize, 8)
  }

  func testLaunchStateAtWorker() throws {
    let rootWorker: LaunchWorkable = MockLaunchWorker()
    XCTAssertEqual(rootWorker.isComplete, false)
    rootWorker.state = .complete
    XCTAssertEqual(rootWorker.isComplete, true)

    let firstItem: LaunchWorkable = MockLaunchWorker()
    rootWorker.push(item: firstItem)
    XCTAssertEqual(rootWorker.isComplete, false)
    firstItem.state = .complete
    XCTAssertEqual(rootWorker.isComplete, true)
    firstItem.state = .running
    XCTAssertEqual(rootWorker.isComplete, false)

    let secondItem: MockLaunchWorker = .init()
    firstItem.push(item: secondItem)
    XCTAssertEqual(rootWorker.isComplete, false)
    firstItem.state = .complete
    secondItem.state = .complete
    XCTAssertEqual(rootWorker.isComplete, true)
    secondItem.state = .running
    XCTAssertEqual(rootWorker.isComplete, false)
    secondItem.state = .ready
    XCTAssertEqual(rootWorker.isComplete, false)
    firstItem.state = .ready
    secondItem.state = .complete
    XCTAssertEqual(rootWorker.isComplete, false)

    let thirdItem: MockLaunchWorker = .init()
    firstItem.state = .complete
    secondItem.state = .complete
    rootWorker.push(item: thirdItem)
    XCTAssertEqual(rootWorker.isComplete, false)
    thirdItem.state = .complete
    XCTAssertEqual(rootWorker.isComplete, true)
    firstItem.state = .ready
    XCTAssertEqual(rootWorker.isComplete, false)
  }
}
