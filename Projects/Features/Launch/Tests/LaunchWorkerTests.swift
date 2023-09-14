import XCTest
@testable import Launch
@testable import LaunchInterface
@testable import LaunchTesting

final class LaunchWorkerTests: XCTestCase {

  // MARK: - Property

  private var singleWorker: MockLaunchWorker!

  private var chainWorker: MockLaunchWorker!

  // MARK: - Tests

  override func setUp() async throws {
    self.singleWorker = .init()
    self.singleWorker.completionSender = LaunchCompletionSender()

    self.chainWorker = .init()
    self.chainWorker.completionSender = LaunchCompletionSender()
    let childWorker: MockLaunchWorker = .init()
    await self.chainWorker.push(item: childWorker)
  }

  /// 단일 워커에서 LaunchState가 Ready인 경우 IsComplete 테스트
  func testIsCompleteWhenReadyAtSingleWorker() {
    self.singleWorker.state = .ready

    XCTAssertEqual(self.singleWorker.isComplete, false)
  }

  /// 단일 워커에서 LaunchState가 Running인 경우 IsComplete 테스트
  func testIsCompleteWhenRunningAtSingleWorker() {
    self.singleWorker.state = .running

    XCTAssertEqual(self.singleWorker.isComplete, false)
  }

  /// 단일 워커에서 LaunchState가 Complete인 경우 IsComplete 테스트
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

  /// 단일 워커 아이템 추가 테스트
  func testPushItemAtSingleWorker() async {
    let firstWorker = MockLaunchWorker()
    let secondWorker = MockLaunchWorker()
    let thirdWorker = MockLaunchWorker()

    await self.singleWorker.push(item: firstWorker)
    await self.singleWorker.push(item: secondWorker)
    await self.singleWorker.push(item: thirdWorker)

    XCTAssertEqual(self.singleWorker.items.count, 3)
  }

  /// 연쇄 워커 아이템 추가 테스트
  func testPushItemAtChainWorker() async {
    let subWorker = self.chainWorker.items.first!
    let firstWorker = MockLaunchWorker()
    let secondWorker = MockLaunchWorker()

    await self.chainWorker.push(item: firstWorker)
    await subWorker.push(item: secondWorker)

    XCTAssertEqual(self.chainWorker.items.count, 2)
    XCTAssertEqual(subWorker.items.count, 1)
  }

  /// 단일 루트 워커 테스트
  func testRootWorkerAtSingleWorker() {
    if let root = self.singleWorker.root as? MockLaunchWorker {
      XCTAssertEqual(root.id, self.singleWorker.id)
    } else {
      XCTFail()
    }
  }

  /// 연쇄 루트 워커 테스트
  func testRootWorkerAtChainWorker() {
    guard let subWorker = self.chainWorker.items.first,
          let subWorkerRoot = subWorker.root as? MockLaunchWorker else {
      XCTFail()
      return
    }

    XCTAssertEqual(subWorkerRoot.id, self.chainWorker.id)
  }

  /// 단일 워커 총 갯수 하나인 경우 테스트
  func testTotalCountOneAtSingleWorker() {
    XCTAssertEqual(self.singleWorker.totalCount, 1)
  }

  /// 단일 워커 총 갯수 테스트
  func testTotalCountAtSingleWorker() async {
    let worker  = MockLaunchWorker()

    await self.singleWorker.push(item: worker)

    XCTAssertEqual(self.singleWorker.totalCount, 2)
    XCTAssertEqual(worker.root.totalCount, 2)
  }

  /// 연쇄 워커 총 갯수 테스트
  func testTotalCountAtChainWorker() async {
    let firstWorker  = MockLaunchWorker()
    let secondWorker  = MockLaunchWorker()

    await self.chainWorker.push(item: firstWorker)
    await self.chainWorker.items.first?.push(item: secondWorker)

    XCTAssertEqual(self.chainWorker.totalCount, 4)
    XCTAssertEqual(secondWorker.root.totalCount, 4)
  }

  /// 단일 워커 Run 함수 테스트
  func testRunAtSingleWorker() async throws {
    try await self.singleWorker.run()

    XCTAssertEqual(self.singleWorker.isComplete, true)
    XCTAssertEqual(self.singleWorker.workString, "\(self.singleWorker.id)")
  }

  /// 단일 워커 Run 함수 오류 테스트
  func testRunErrorAtSingleWorker() async {
    self.singleWorker.error = MockLaunchWorkerError.runError

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

    await self.chainWorker.push(item: secondSubWorker)
    await firstSubWorker.push(item: thirdSubWorker)

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
    firstSubWorker.error = MockLaunchWorkerError.runError
    let secondSubWorker: MockLaunchWorker = .init()

    await firstSubWorker.push(item: secondSubWorker)

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

  /// LaunchCompletionSender 단일 워커 테스트
  func testCompletionCountAtSingleWorker() async throws {
    var result: LaunchCompletionCounter?
    await self.singleWorker.completionSender?.setCompletion { counter in
      result = counter
    }

    try await self.singleWorker.run()

    if let result = result {
      XCTAssertEqual(
        result,
        LaunchCompletionCounter(totalCount: 1, completedCount: 1)
      )
    } else {
      XCTFail()
    }
  }

  /// LaunchCompletionSender 연쇄 워커 테스트
  func testCompletionCountAtChainWorker() async throws {
    let secondWorker  = MockLaunchWorker()
    let thirdWorker  = MockLaunchWorker()

    await self.chainWorker.push(item: secondWorker)
    await self.chainWorker.items.first?.push(item: thirdWorker)

    var result: [LaunchCompletionCounter] = []
    await self.chainWorker.completionSender?.setCompletion { counter in
      if let counter = counter {
        result.append(counter)
      }
    }

    try await self.chainWorker.run()

    XCTAssertEqual(result.count, 4)
    XCTAssertEqual(result[0].completedCount, 1)
    XCTAssertEqual(result[0].totalCount, 4)
    XCTAssertEqual(result[1].completedCount, 2)
    XCTAssertEqual(result[1].totalCount, 4)
    XCTAssertEqual(result[2].completedCount, 3)
    XCTAssertEqual(result[2].totalCount, 4)
    XCTAssertEqual(result[3].completedCount, 4)
    XCTAssertEqual(result[3].totalCount, 4)
  }

  /// 연쇄 워커 재시작 테스트
  func testRetryRunAtChainWorker() async {
    let firstSubWorker = self.chainWorker.items.first as! MockLaunchWorker
    firstSubWorker.error = MockLaunchWorkerError.runError

    do {
      try await self.chainWorker.run()
    } catch {
      XCTAssertEqual(self.chainWorker.isComplete, false)
      XCTAssertEqual(self.chainWorker.state, .complete)
      XCTAssertEqual(firstSubWorker.state, .ready)
      XCTAssertEqual(self.chainWorker.workString, "\(self.chainWorker.id)")

      firstSubWorker.error = nil

      do {
        try await self.chainWorker.run()
      } catch {
        XCTAssertEqual(self.chainWorker.isComplete, true)
        XCTAssertEqual(self.chainWorker.state, .complete)
        XCTAssertEqual(firstSubWorker.state, .complete)
        XCTAssertEqual(self.chainWorker.workString, "\(self.chainWorker.id)\(firstSubWorker.id)")
      }
    }
  }
}
