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
    let childWorker: MockLaunchWorker = .init()
    self.chainWorker.push(item: childWorker)
    childWorker.parent = self.chainWorker
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
    let firstWorker = MockLaunchWorker()
    let secondWorker = MockLaunchWorker()

    self.chainWorker.push(item: firstWorker)
    subWorker.push(item: secondWorker)

    XCTAssertEqual(self.chainWorker.items.count, 2)
    XCTAssertEqual(subWorker.items.count, 1)
  }

  /// Root Worker 총 갯수 테스트
  func testTotalSizeAtRootWorker() {
    let fristWorker  = MockLaunchWorker()
    let secondWorker  = MockLaunchWorker()

    self.rootWorker.push(item: fristWorker)
    self.rootWorker.push(item: secondWorker)

    XCTAssertEqual(rootWorker.totalSize, 3)
  }

  /// Chain Worker Total Size 테스트
  func testTotalSizeAtChainWorker() {
    let fristWorker  = MockLaunchWorker()
    let secondWorker  = MockLaunchWorker()
    self.chainWorker.push(item: fristWorker)
    self.chainWorker.items.first?.push(item: secondWorker)

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

  /// Chain Worekr에서 LaunchState가 모두 Ready인 경우 IsComplete 테스트
  func testIsCompleteWhenAllReadyAtChainWorker() {
    self.chainWorker.state = .ready
    self.chainWorker.items.first?.state = .ready

    XCTAssertEqual(self.chainWorker.isComplete, false)
  }

  /// Chain Worekr에서 LaunchState가 하나만 Ready인 경우 IsComplete 테스트
  func testIsCompleteWhenOnlyOneReadyAtChainWorker() {
    self.chainWorker.state = .complete
    self.chainWorker.items.first?.state = .ready

    XCTAssertEqual(self.chainWorker.isComplete, false)
  }

  /// Chain Worekr에서 LaunchState가 모두 Running인 경우 IsComplete 테스트
  func testIsCompleteWhenAllRunningAtChainWorker() {
    self.chainWorker.state = .running
    self.chainWorker.items.first?.state = .running

    XCTAssertEqual(self.chainWorker.isComplete, false)
  }

  /// Chain Worekr에서 LaunchState가 하나만 Running인 경우 IsComplete 테스트
  func testIsCompleteWhenOnlyOneRunningAtChainWorker() {
    self.chainWorker.state = .complete
    self.chainWorker.items.first?.state = .running

    XCTAssertEqual(self.chainWorker.isComplete, false)
  }

  /// Chain Worekr에서 LaunchState가 모두 Complete인 경우 IsComplete 테스트
  func testIsCompleteWhenAllCompleteAtChainWorker() {
    self.chainWorker.state = .complete
    self.chainWorker.items.first?.state = .complete
    
    XCTAssertEqual(self.chainWorker.isComplete, true)
  }

  /// Root Worker Run 함수 테스트
  func testRunAtRootWorker() async throws {
    try await self.rootWorker.run()

    XCTAssertEqual(self.rootWorker.isComplete, true)
    XCTAssertEqual(self.rootWorker.workString, "\(self.rootWorker.id)")
  }

  /// Root Worker Run 함수 오류 테스트
  func testRunErrorAtRootWorker() async {
    self.rootWorker.isError = true

    do {
      try await self.rootWorker.run()
      XCTFail()
    } catch {
      XCTAssertEqual(self.rootWorker.isComplete, false)
      XCTAssertEqual(self.rootWorker.workString, "")
    }
  }

  /// Chain Worker Run 함수 테스트
  func testRunAtChainWorker() async throws {
    let firstSubWorker = self.chainWorker.items.first as! MockLaunchWorker
    let secondSubWorker: MockLaunchWorker = .init()
    let thirdSubWorker: MockLaunchWorker = .init()

    self.chainWorker.push(item: secondSubWorker)
    secondSubWorker.parent = self.chainWorker

    firstSubWorker.push(item: thirdSubWorker)
    thirdSubWorker.parent = firstSubWorker

    try await self.chainWorker.run()

    XCTAssertEqual(self.chainWorker.isComplete, true)

    var compareString = "\(self.chainWorker.id)\(firstSubWorker.id)"
    XCTAssertEqual(firstSubWorker.workString, compareString)

    compareString += "\(thirdSubWorker.id)"
    XCTAssertEqual(thirdSubWorker.workString, compareString)

    compareString = "\(self.chainWorker.id)\(secondSubWorker.id)"
    XCTAssertEqual(secondSubWorker.workString, compareString)
  }

  /// Chain Worker Run 함수 오류 테스트
  func testRunErrorAtChainWorker() async {
    let firstSubWorker = self.chainWorker.items.first as! MockLaunchWorker
    firstSubWorker.isError = true
    let secondSubWorker: MockLaunchWorker = .init()

    firstSubWorker.push(item: secondSubWorker)
    secondSubWorker.parent = firstSubWorker

    do {
      try await self.chainWorker.run()
      XCTFail()
    } catch {
      XCTAssertEqual(self.chainWorker.isComplete, false)
      XCTAssertEqual(self.chainWorker.workString, "\(self.chainWorker.id)")
      XCTAssertEqual(firstSubWorker.workString, "")
      XCTAssertEqual(secondSubWorker.workString, "")
    }
  }
}
