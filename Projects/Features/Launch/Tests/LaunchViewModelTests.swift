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
@testable import VersionInterface

final class LaunchViewModelTests: XCTestCase {

  // MARK: - Property

  private var cancellables: Set<AnyCancellable>!

  private var builder: MockLaunchWorkerBuilder!

  // MARK: - Tests

  override func setUp() async throws {
    try await super.setUp()

    self.cancellables = .init()
    self.builder = .init()
  }

  /// 재시도 테스트
  func testRetry() async {
    self.builder.error = MockLaunchWorkerError.runError
    let viewModel: LaunchViewModel = .init(builder: self.builder)

    await viewModel.trigger(.buildForWorker)
    await viewModel.trigger(.runAsync)
    await viewModel.trigger(.runAsync)

    XCTAssertEqual(viewModel.retryCount, 2)
  }

  /// 한계 수치까지만 재시도 하는지 테스트
  func testLimitRetryCount() async {
    self.builder.error = MockLaunchWorkerError.runError
    let viewModel: LaunchViewModel = .init(builder: self.builder)
    let limitRetryCount = 3
    viewModel.limitRetryCount = limitRetryCount

    await viewModel.trigger(.buildForWorker)
    await viewModel.trigger(.runAsync)
    await viewModel.trigger(.runAsync)
    await viewModel.trigger(.runAsync)

    XCTAssertEqual(viewModel.retryCount, limitRetryCount)
  }

  /// (완료한 갯수 / 총 갯수) 테스트
  func testCompletionCount() {
    let expectation: XCTestExpectation = .init(
      description: "CompletionCountExpectaion"
    )
    let results: [String] = ["0/2", "1/2", "2/2"]
    var index = 0
    let viewModel: LaunchViewModel = .init(builder: self.builder)
    
    viewModel.trigger(.runAfterBuildForWoker)

    viewModel.$state
      .dropFirst()
      .sink { state in
        XCTAssertEqual(results[index], state.completionCountMessage)
        index += 1
        if index >= results.count {
          expectation.fulfill()
        }
      }
      .store(in: &self.cancellables)

    wait(for: [expectation], timeout: 5.0)
  }

  /// (완료한 갯수 / 총 갯수) 클리어
  func testClearCount() async {
    let viewModel: LaunchViewModel = .init(builder: self.builder)

    await viewModel.trigger(.buildForWorker)
    await viewModel.trigger(.runAsync)

    XCTAssertEqual(viewModel.state.completionCountMessage, "2/2")

    await viewModel.trigger(.clearCountAsync)

    XCTAssertEqual(viewModel.state.completionCountMessage, "")
  }

  /// 알럿 테스트
  func testPresentAlert() {
    let expectation: XCTestExpectation = .init(
      description: "NeedUpdateExpectation"
    )
    self.builder.error = MockLaunchWorkerError.runError
    let viewModel: LaunchViewModel = .init(builder: self.builder)

    viewModel.trigger(.runAfterBuildForWoker)

    viewModel.$state
      .filter { state in state.alert != .empty }
      .sink { state in
        XCTAssertEqual(
          state.alert,
            .init(
              title: "",
              message: "작업을 완료할 수 없습니다.(LaunchTesting.MockLaunchWorkerError 오류 0.)",
              primaryAction: .init(
                title: LaunchViewModel.TextConstant.retry,
                type: .default,
                completion: nil
              ),
              secondaryAction: nil
            )
        )
        expectation.fulfill()
      }
      .store(in: &self.cancellables)

    wait(for: [expectation], timeout: 5.0)
  }

  /// 강제 업데이트 알럿 테스트
  func testPresentNeedUpdateAlert() {
    let expectation: XCTestExpectation = .init(
      description: "NeedUpdateExpectation"
    )
    let entity = CheckVersionEntity(
      isNeedUpdate: true,
      message: "업데이트가 필요합니다.",
      linkURL: .init(fileURLWithPath: "")
    )
    self.builder.error = CheckVersionLaunchWorkError.needUpdate(entity)
    let viewModel: LaunchViewModel = .init(builder: self.builder)

    viewModel.trigger(.runAfterBuildForWoker)

    viewModel.$state
      .filter { state in state.alert != .empty }
      .sink { state in
        XCTAssertEqual(
          state.alert,
            .init(
              title: "",
              message: entity.message,
              primaryAction: .init(
                title: LaunchViewModel.TextConstant.confirm,
                type: .openURL(url: entity.linkURL),
                completion: nil
              ),
              secondaryAction: nil
            )
        )
        expectation.fulfill()
      }
      .store(in: &self.cancellables)

    wait(for: [expectation], timeout: 5.0)
  }
}
