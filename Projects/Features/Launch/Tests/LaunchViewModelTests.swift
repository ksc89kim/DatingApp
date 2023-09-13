//
//  LaunchViewModelTests.swift
//  LaunchTests
//
//  Created by kim sunchul on 2023/09/12.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import XCTest
import Combine
@testable import Launch
@testable import LaunchTesting

final class LaunchViewModelTests: XCTestCase {

  // MARK: - Property

  private var cancellables: Set<AnyCancellable>!

  private var builder: MockLaunchWorkerBuilder!

  private var viewModel: LaunchViewModel!

  // MARK: - Tests

  override func setUp() async throws {
    try await super.setUp()

    self.cancellables = .init()

    self.builder = MockLaunchWorkerBuilder(completionSendable: LaunchCompletionSender())
    self.viewModel = .init(builder: self.builder)
  }

  /// (완료한 갯수 / 총 갯수) 테스트
  func testCompletionCount() {
    let expectation: XCTestExpectation = .init(
      description: "CompletionCountExpectaion"
    )
    let results: [String] = ["", "0/2", "1/2", "2/2"]
    var index = 0

    self.viewModel.run()

    self.viewModel.$completionCount.sink { completionCount in
      XCTAssertEqual(results[index], completionCount)
      index += 1
      if index >= results.count {
        expectation.fulfill()
      }
    }
    .store(in: &self.cancellables)

    wait(for: [expectation], timeout: 5.0)
  }
}
