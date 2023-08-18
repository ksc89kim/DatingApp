import XCTest
@testable import LaunchInterface
@testable import LaunchTesting

final class LaunchWorkerTests: XCTestCase {

  // MARK: - Property

  var singleWorker: MockLaunchWorker!

  var chainWorker: MockLaunchWorker!

  // MARK: - Tests

  override func setUp() {
    super.setUp()
    self.singleWorker = .init()

    self.chainWorker = .init()
    let childWorker: MockLaunchWorker = .init()
    self.chainWorker.push(item: childWorker)
    childWorker.parent = self.chainWorker
  }

  /// 단일 워커 아이템 추가 테스트
  func testPushItemAtSingleWorker() {
    let firstWorker = MockLaunchWorker()
    let secondWorker = MockLaunchWorker()
    let thirdWorker = MockLaunchWorker()

    self.singleWorker.push(item: firstWorker)
    self.singleWorker.push(item: secondWorker)
    self.singleWorker.push(item: thirdWorker)

    XCTAssertEqual(self.singleWorker.items.count, 3)
  }

  /// 연쇄 워커 아이템 추가 테스트
  func testPushItemAtChainWorker() {
    let subWorker = self.chainWorker.items.first!
    let firstWorker = MockLaunchWorker()
    let secondWorker = MockLaunchWorker()

    self.chainWorker.push(item: firstWorker)
    subWorker.push(item: secondWorker)

    XCTAssertEqual(self.chainWorker.items.count, 2)
    XCTAssertEqual(subWorker.items.count, 1)
  }

  /// 싱글 워커 총 갯수 테스트
  func testTotalSizeAtSingleWorker() {
    let fristWorker  = MockLaunchWorker()
    let secondWorker  = MockLaunchWorker()

    self.singleWorker.push(item: fristWorker)
    self.singleWorker.push(item: secondWorker)

    XCTAssertEqual(singleWorker.totalSize, 3)
  }

  /// Chain Worker Total Size 테스트
  func testTotalSizeAtChainWorker() {
    let fristWorker  = MockLaunchWorker()
    let secondWorker  = MockLaunchWorker()
    self.chainWorker.push(item: fristWorker)
    self.chainWorker.items.first?.push(item: secondWorker)

    XCTAssertEqual(self.chainWorker.totalSize, 4)
  }

  /// 싱글 워커에서 LaunchState가 Ready인 경우 IsComplete 테스트
  func testIsCompleteWhenReadyAtSingleWorker() {
    self.singleWorker.state = .ready

    XCTAssertEqual(self.singleWorker.isComplete, false)
  }

  /// 싱글 워커에서 LaunchState가 Running인 경우 IsComplete 테스트
  func testIsCompleteWhenRunningAtSingleWorker() {
    self.singleWorker.state = .running

    XCTAssertEqual(self.singleWorker.isComplete, false)
  }

  /// 싱글 워커에서 LaunchState가 Complete인 경우 IsComplete 테스트
  func testIsCompleteWhenCompleteAtSingleWorker() {
    self.singleWorker.state = .complete

    XCTAssertEqual(self.singleWorker.isComplete, true)
  }

  /// 연쇄 워커에서 LaunchState가 모두 Ready인 경우 IsComplete 테스트
  func testIsCompleteWhenAllReadyAtChainWorker() {
    self.chainWorker.state = .ready
    self.chainWorker.items.first?.state = .ready

    XCTAssertEqual(self.chainWorker.isComplete, false)
  }

  /// 연쇄 워커에서 LaunchState가 하나만 Ready인 경우 IsComplete 테스트
  func testIsCompleteWhenOnlyOneReadyAtChainWorker() {
    self.chainWorker.state = .complete
    self.chainWorker.items.first?.state = .ready

    XCTAssertEqual(self.chainWorker.isComplete, false)
  }

  /// 연쇄 워커에서 LaunchState가 모두 Running인 경우 IsComplete 테스트
  func testIsCompleteWhenAllRunningAtChainWorker() {
    self.chainWorker.state = .running
    self.chainWorker.items.first?.state = .running

    XCTAssertEqual(self.chainWorker.isComplete, false)
  }

  /// 연쇄 워커에서 LaunchState가 하나만 Running인 경우 IsComplete 테스트
  func testIsCompleteWhenOnlyOneRunningAtChainWorker() {
    self.chainWorker.state = .complete
    self.chainWorker.items.first?.state = .running

    XCTAssertEqual(self.chainWorker.isComplete, false)
  }

  /// 연쇄 워커에서 LaunchState가 모두 Complete인 경우 IsComplete 테스트
  func testIsCompleteWhenAllCompleteAtChainWorker() {
    self.chainWorker.state = .complete
    self.chainWorker.items.first?.state = .complete
    
    XCTAssertEqual(self.chainWorker.isComplete, true)
  }

  /// 싱글 워커 Run 함수 테스트
  func testRunAtSingleWorker() async throws {
    try await self.singleWorker.run()

    XCTAssertEqual(self.singleWorker.isComplete, true)
    XCTAssertEqual(self.singleWorker.workString, "\(self.singleWorker.id)")
  }

  /// 싱글 워커 Run 함수 오류 테스트
  func testRunErrorAtSingleWorker() async {
    self.singleWorker.isError = true

    do {
      try await self.singleWorker.run()
      XCTFail()
    } catch {
      XCTAssertEqual(self.singleWorker.isComplete, false)
      XCTAssertEqual(self.singleWorker.workString, "")
    }
  }

  /// 연쇄 워커 Run 함수 테스트
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

  /// 연쇄 워커 Run 함수 오류 테스트
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
