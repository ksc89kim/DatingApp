import XCTest
@testable import LaunchInterface
@testable import LaunchTesting

final class LaunchWorkerTests: XCTestCase {

  // MARK: - Property

  var rootWorker: MockLaunchWorker!

  var chainWorker: MockLaunchWorker!

  // MARK: - Tests

  override func setUp() {
    super.setUp()
    self.rootWorker = .init()

    self.chainWorker = .init()
    self.chainWorker.push(item: MockLaunchWorker())
  }

  /// Root Worker 아이템 추가 테스트
  func testPushItemAtRootWorker() {
    let firstWorker = MockLaunchWorker()
    let secondWorker = MockLaunchWorker()
    let thirdWorker = MockLaunchWorker()

    self.rootWorker.push(item: firstWorker)
    self.rootWorker.push(item: secondWorker)
    self.rootWorker.push(item: thirdWorker)

    XCTAssertEqual(self.rootWorker.items.count, 3)
  }

  /// Chain Worker 아이템 추가 테스트
  func testPushItemAtChainWorker() {
    let subWorker = self.chainWorker.items.first!
    let firstItem = MockLaunchWorker()
    let secondItem = MockLaunchWorker()

    self.chainWorker.push(item: firstItem)
    subWorker.push(item: secondItem)

    XCTAssertEqual(self.chainWorker.items.count, 2)
    XCTAssertEqual(subWorker.items.count, 1)
  }

  /// Root Worker 총 갯수 테스트
  func testTotalSizeAtRootWorker() {
    let fristItem  = MockLaunchWorker()
    let secondItem  = MockLaunchWorker()

    self.rootWorker.push(item: fristItem)
    self.rootWorker.push(item: secondItem)

    XCTAssertEqual(rootWorker.totalSize, 3)
  }

  /// Chain Worker Total Size 테스트
  func testTotalSizeAtChainWorker() {
    let item = MockLaunchWorker()
    self.chainWorker.push(item: item)
    self.chainWorker.items.first?.push(item: item)

    XCTAssertEqual(self.chainWorker.totalSize, 4)
  }

  /// Root Worker에서 LaunchState가 Ready인 경우 IsComplete 테스트
  func testIsCompleteWhenReadyAtRootWorker() {
    self.rootWorker.state = .ready

    XCTAssertEqual(self.rootWorker.isComplete, false)
  }

  /// Root Worker에서 LaunchState가 Running인 경우 IsComplete 테스트
  func testIsCompleteWhenRunningAtRootWorker() {
    self.rootWorker.state = .running

    XCTAssertEqual(self.rootWorker.isComplete, false)
  }

  /// Root Worker에서 LaunchState가 Complete인 경우 IsComplete 테스트
  func testIsCompleteWhenCompleteAtRootWorker() {
    self.rootWorker.state = .complete

    XCTAssertEqual(self.rootWorker.isComplete, true)
  }

  /// ChainWorekr에서 LaunchState가 모두 Ready인 경우 IsComplete 테스트
  func testIsCompleteWhenAllReadyAtChainWorker() {
    self.chainWorker.state = .ready
    self.chainWorker.items.first?.state = .ready

    XCTAssertEqual(self.chainWorker.isComplete, false)
  }

  /// ChainWorekr에서 LaunchState가 하나만 Ready인 경우 IsComplete 테스트
  func testIsCompleteWhenOnlyOneReadyAtChainWorker() {
    self.chainWorker.state = .complete
    self.chainWorker.items.first?.state = .ready

    XCTAssertEqual(self.chainWorker.isComplete, false)
  }

  /// ChainWorekr에서 LaunchState가 모두 Running인 경우 IsComplete 테스트
  func testIsCompleteWhenAllRunningAtChainWorker() {
    self.chainWorker.state = .running
    self.chainWorker.items.first?.state = .running

    XCTAssertEqual(self.chainWorker.isComplete, false)
  }

  /// ChainWorekr에서 LaunchState가 하나만 Running인 경우 IsComplete 테스트
  func testIsCompleteWhenOnlyOneRunningAtChainWorker() {
    self.chainWorker.state = .complete
    self.chainWorker.items.first?.state = .running

    XCTAssertEqual(self.chainWorker.isComplete, false)
  }

  /// ChainWorekr에서 LaunchState가 모두 Complete인 경우 IsComplete 테스트
  func testIsCompleteWhenAllCompleteAtChainWorker() {
    self.chainWorker.state = .complete
    self.chainWorker.items.first?.state = .complete
    
    XCTAssertEqual(self.chainWorker.isComplete, true)
  }
}
