//
//  LaunchViewModelTests.swift
//  LaunchTests
//
//  Created by kim sunchul on 2023/09/12.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import XCTest
import Combine
@testable import Core
@testable import LaunchInterface
@testable import Launch
@testable import LaunchTesting
@testable import VersionInterface
@testable import DI
@testable import AppStateInterface
@testable import AppStateTesting

final class LaunchViewModelTests: XCTestCase {

  // MARK: - Property

  private var cancellables: Set<AnyCancellable>!

  // MARK: - Tests

  override func setUp() async throws {
    try await super.setUp()

    self.cancellables = .init()

    DIContainer.register {
      InjectItem(LaunchWorkerBuilderKey.self) { MockLaunchWorkerBuilder() }
      InjectItem(AppStateKey.self) {
        AppState.instance.router.removeAll(for: RouteKey.main)
        AppState.instance.router.removeAll(for: MockRouteKey.mock)
        return AppState.instance
      }
      InjectItem(RouteInjectionKey.self) { MockRouter() }
    }
  }

  /// 재시도 테스트
  func testRetry() async {
    DIContainer.register {
      InjectItem(LaunchWorkerBuilderKey.self) {
        var builder = MockLaunchWorkerBuilder()
        builder.error = MockLaunchWorkerError.runError
        return builder
      }
    }
    let viewModel: LaunchViewModel = .init(tokenManager: MockTokenManager())

    await viewModel.trigger(.buildForWorker)
    await viewModel.trigger(.run)
    await viewModel.trigger(.run)

    XCTAssertEqual(viewModel.retry.count, 2)
  }

  /// 한계 수치까지만 재시도 하는지 테스트
  func testLimitRetryCount() async {
    DIContainer.register {
      InjectItem(LaunchWorkerBuilderKey.self) {
        var builder = MockLaunchWorkerBuilder()
        builder.error = MockLaunchWorkerError.runError
        return builder
      }
    }
    let viewModel: LaunchViewModel = .init(tokenManager: MockTokenManager())
    let limitRetryCount = 3
    viewModel.limitRetryCount = limitRetryCount

    await viewModel.trigger(.buildForWorker)
    await viewModel.trigger(.run)
    await viewModel.trigger(.run)
    await viewModel.trigger(.run)

    XCTAssertEqual(viewModel.retry.count, limitRetryCount)
  }

  /// (완료한 갯수 / 총 갯수) 테스트
  func testCompletionCount() {
    let expectation: XCTestExpectation = .init(
      description: "CompletionCountExpectaion"
    )
    let viewModel: LaunchViewModel = .init(tokenManager: MockTokenManager())
    var index = 0
    let totalCount = 2

    viewModel.trigger(.runAfterBuildForWoker)

    viewModel.$state
      .removeDuplicates { lhs, rhs in
        lhs.completedCount == rhs.completedCount
      }
      .dropFirst()
      .sink { state in
        index += 1
        XCTAssertEqual(index, state.completedCount)
        XCTAssertEqual(totalCount, state.totalCount)
        if state.completedCount == state.totalCount {
          expectation.fulfill()
        }
      }
      .store(in: &self.cancellables)

    wait(for: [expectation], timeout: 5.0)
  }

  /// (완료한 갯수 / 총 갯수) 클리어
  func testClearCount() async {
    let viewModel: LaunchViewModel = .init(tokenManager: MockTokenManager())

    await viewModel.trigger(.buildForWorker)
    await viewModel.trigger(.run)

    XCTAssertEqual(viewModel.state.totalCount, 2)
    XCTAssertEqual(viewModel.state.completedCount, 2)

    await viewModel.trigger(.clearCount)

    XCTAssertEqual(viewModel.state.completedCount, 0)
    XCTAssertEqual(viewModel.state.totalCount, 0)
  }

  /// 하단 메시지 테스트
  func testBottomMessage() async {
    let viewModel: LaunchViewModel = .init(tokenManager: MockTokenManager())

    await viewModel.trigger(.buildForWorker)
    await viewModel.trigger(.run)

    XCTAssertEqual(viewModel.state.bottomMessage, "2/2")
  }

  /// 알럿 테스트
  func testPresentAlert() {
    let expectation: XCTestExpectation = .init(
      description: "NeedUpdateExpectation"
    )
    DIContainer.register {
      InjectItem(LaunchWorkerBuilderKey.self) {
        var builder = MockLaunchWorkerBuilder()
        builder.error = MockLaunchWorkerError.runError
        return builder
      }
    }
    let viewModel: LaunchViewModel = .init(tokenManager: MockTokenManager())

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
  func testPresentForceUpdateAlert() {
    let expectation: XCTestExpectation = .init(
      description: "NeedUpdateExpectation"
    )
    let entity = CheckVersionEntity(
      isForceUpdate: true,
      message: "업데이트가 필요합니다.",
      linkURL: .init(fileURLWithPath: "")
    )
    DIContainer.register {
      InjectItem(LaunchWorkerBuilderKey.self) {
        var builder = MockLaunchWorkerBuilder()
        builder.error = CheckVersionLaunchWorkError.forceUpdate(entity)
        return builder
      }
    }
    let viewModel: LaunchViewModel = .init(tokenManager: MockTokenManager())

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

  /// 강제 업데이트 확인 테스트
  func testCheckForceUpdate() {
    let viewModel: LaunchViewModel = .init(tokenManager: MockTokenManager())
    viewModel.isForceUpdate = true

    XCTAssertFalse(viewModel.state.isPresentAlert)

    viewModel.trigger(.checkForceUpdate)

    XCTAssertTrue(viewModel.state.isPresentAlert)
  }

  /// 메인 화면으로 이동
  func testPresentMain() async {
    let tokenManager: MockTokenManager = .init(token: "ABCD")
    let viewModel: LaunchViewModel = .init(tokenManager: tokenManager)
    let state: AppState = DIContainer.resolve(for: AppStateKey.self)

    await viewModel.trigger(.buildForWorker)
    await viewModel.trigger(.run)
    
    XCTAssertTrue(state.router.main.isEmpty)
  }

  /// 온보딩 화면으로 이동
  func testPresentOnboarding() async {
    let viewModel: LaunchViewModel = .init(tokenManager: MockTokenManager())
    let state: AppState = DIContainer.resolve(for: AppStateKey.self)

    await viewModel.trigger(.buildForWorker)
    await viewModel.trigger(.run)

    XCTAssertFalse(state.router.main.isEmpty)
    XCTAssertEqual(state.router.main.first, .onboarding)
  }
}
