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

    await viewModel.build()
    await viewModel.run()
    await viewModel.run()

    XCTAssertEqual(viewModel.retryCount, 2)
  }

  /// 한계 수치까지만 재시도 하는지 테스트
  func testLimitRetry() async {
    self.builder.error = MockLaunchWorkerError.runError
    let viewModel: LaunchViewModel = .init(builder: self.builder)

    await viewModel.build()
    await viewModel.run()
    await viewModel.run()
    await viewModel.run()
    await viewModel.run()

    XCTAssertEqual(viewModel.retryCount, LaunchViewModel.Constant.limitRetry)
  }

  /// (완료한 갯수 / 총 갯수) 테스트
  func testCompletionCount() {
    let expectation: XCTestExpectation = .init(
      description: "CompletionCountExpectaion"
    )
    let results: [String] = ["0/2", "1/2", "2/2"]
    var index = 0
    let viewModel: LaunchViewModel = .init(builder: self.builder)
    
    viewModel.runAfterBuild()

    viewModel.$completionCount
      .dropFirst()
      .sink { completionCount in
        XCTAssertEqual(results[index], completionCount)
        index += 1
        if index >= results.count {
          expectation.fulfill()
        }
      }
      .store(in: &self.cancellables)

    wait(for: [expectation], timeout: 5.0)
  }

  /// 알럿 테스트
  func testPresentAlert() {
    let expectation: XCTestExpectation = .init(
      description: "NeedUpdateExpectation"
    )
    self.builder.error = MockLaunchWorkerError.runError
    let viewModel: LaunchViewModel = .init(builder: self.builder)

    viewModel.runAfterBuild()

    viewModel.$isPresentAlert
      .dropFirst()
      .sink { isPresentAlert in
        XCTAssertTrue(isPresentAlert)
        XCTAssertEqual(viewModel.alert.title, "")
        XCTAssertEqual(
          viewModel.alert.message,
          "작업을 완료할 수 없습니다.(LaunchTesting.MockLaunchWorkerError 오류 0.)"
        )
        XCTAssertEqual(viewModel.alert.primaryAction.type, .default)
        XCTAssertEqual(
          viewModel.alert.primaryAction.title,
          LaunchViewModel.TextConstant.retry
        )
        XCTAssertNil(viewModel.alert.secondaryAction)
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

    viewModel.runAfterBuild()

    viewModel.$isPresentAlert
      .dropFirst()
      .sink { isPresentAlert in
        XCTAssertTrue(isPresentAlert)
        XCTAssertEqual(viewModel.alert.title, "")
        XCTAssertEqual(
          viewModel.alert.message,
          entity.message
        )
        XCTAssertEqual(
          viewModel.alert.primaryAction.type,
            .openURL(url: entity.linkURL)
        )
        XCTAssertEqual(
          viewModel.alert.primaryAction.title,
          LaunchViewModel.TextConstant.confirm
        )
        XCTAssertNil(viewModel.alert.secondaryAction)
        expectation.fulfill()
      }
      .store(in: &self.cancellables)

    wait(for: [expectation], timeout: 5.0)
  }
}
