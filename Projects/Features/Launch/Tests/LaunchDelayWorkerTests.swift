//
//  LaunchDelayWorkerTests.swift
//  LaunchTests
//
//  Created by kim sunchul on 2023/09/20.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import XCTest
@testable import Launch

final class LaunchDelayWorkerTests: XCTestCase {

  /// 딜레이 시간 -> 나노초 테스트
  func testNanosecondsAtDelayTime() {
    let oneSecondsWorker = LaunchDelayWorker(delayTime: 1.0)
    let twoSecondsWorker = LaunchDelayWorker(delayTime: 2.0)
    let zeroPointFiveWorker = LaunchDelayWorker(delayTime: 0.5)

    XCTAssertEqual(oneSecondsWorker.nanoseconds, 1_000_000_000)
    XCTAssertEqual(twoSecondsWorker.nanoseconds, 2_000_000_000)
    XCTAssertEqual(zeroPointFiveWorker.nanoseconds, 500_000_000)
  }

  /// Timer 시간에 맞춰 지연이 되는지 확인하는 테스트
  func testDelayWorkerTimer() {
    let expectation = XCTestExpectation(description: "TimerExpectation")
    let completeWorker = LaunchDelayWorker(delayTime: 1.0)
    let notCompleteWorker = LaunchDelayWorker(delayTime: 2.1)

    Task {
      await withThrowingTaskGroup(of: Void.self) { group in
        group.addTask {
          try await completeWorker.run()
        }
        group.addTask {
          try await notCompleteWorker.run()
        }
      }
    }

    Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
      XCTAssertTrue(completeWorker.isComplete)
      XCTAssertFalse(notCompleteWorker.isComplete)
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 5.0)
  }
}
