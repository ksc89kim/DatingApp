//
//  SignupViewModelTests.swift
//  UserTests
//
//  Created by kim sunchul on 11/12/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import XCTest
import Combine
@testable import DI
@testable import Core
@testable import User
@testable import UserInterface
@testable import UserTesting
@testable import AppStateInterface
@testable import AppStateTesting

final class SignupViewModelTests: XCTestCase {

  // MARK: - Property

  private var cancellables: Set<AnyCancellable>!

  private var signupError: Error?

  private var loginError: Error?

  private var mockTokenManager: MockTokenManager!

  // MARK: - Method

  override func setUp() {
    super.setUp()

    self.cancellables = .init()
    self.mockTokenManager = .init()
    self.signupError = nil
    self.loginError = nil

    DIContainer.register { [weak self] in
      InjectItem(LoginRepositoryTypeKey.self) {
        let repository = MockLoginRepository()
        repository.error = self?.loginError
        return repository
      }
      InjectItem(LoginKey.self) {
        Login(tokenManager: self?.mockTokenManager ?? MockTokenManager())
      }
      InjectItem(SignupRepositoryTypeKey.self) {
        let repository = MockSignupRepository()
        repository.error = self?.signupError
        return repository
      }
      InjectItem(RouteInjectionKey.self) { MockRouter() }
      InjectItem(AppStateKey.self) { AppState.instance }
    }
  }

  /// UI 초기화
  func testInitUI() {
    let viewModel = SignupViewModel(
      mains: [
        MockSignupMain(isBottomDisable: false, title: "A"),
        MockSignupMain(isBottomDisable: false, title: "B")
      ],
      tokenManager: self.mockTokenManager
    )

    viewModel.trigger(.initUI)

    if let mock = viewModel.state.currentMain as? MockSignupMain {
      XCTAssertEqual(mock.title, "A")
      XCTAssertFalse(viewModel.state.bottomButton.isDisable)
      XCTAssertEqual(viewModel.state.progress.value, 0.5)
      XCTAssertFalse(viewModel.state.progress.isAnimation)
    } else {
      XCTFail()
    }
  }

  /// 초기화가 진행되지 않을 경우 Main nill 확인
  func testCurrentMainNil() {
    let viewModel = SignupViewModel(tokenManager: self.mockTokenManager)

    XCTAssertNil(viewModel.state.currentMain)
  }

  /// 닉네임 설정 테스트
  func testSetNickname() {
    let viewModel = SignupViewModel(
      mains: [SignupNickname()],
      tokenManager: self.mockTokenManager
    )
    viewModel.trigger(.initUI)

    viewModel.trigger(.nickname("테스트"))

    if let nickname = viewModel.state.currentMain as? SignupNickname {
      XCTAssertEqual(nickname.nickname, "테스트")
      XCTAssertFalse(viewModel.state.bottomButton.isDisable)
    } else {
      XCTFail()
    }
  }

  /// 닉네임 0자 일때, 바텀 버튼 disable
  func testDisableBottomButtonWhenNoNickname() {
    let viewModel = SignupViewModel(
      mains: [SignupNickname()],
      tokenManager: self.mockTokenManager
    )

    viewModel.trigger(.initUI)

    if let nickname = viewModel.state.currentMain as? SignupNickname {
      XCTAssertTrue(nickname.nickname.isEmpty)
      XCTAssertTrue(viewModel.state.bottomButton.isDisable)
    } else {
      XCTFail()
    }
  }

  /// 메인 페이지 다음 테스트
  func testNext() {
    let viewModel = SignupViewModel(
      mains: [
        MockSignupMain(isBottomDisable: false, title: "A"),
        MockSignupMain(isBottomDisable: false, title: "B"),
        MockSignupMain(isBottomDisable: true, title: "C")
      ],
      tokenManager: self.mockTokenManager
    )

    viewModel.trigger(.next)
    viewModel.trigger(.next)

    if let mock = viewModel.state.currentMain as? MockSignupMain {
      XCTAssertEqual(mock.title, "C")
      XCTAssertTrue(viewModel.state.bottomButton.isDisable)
    } else {
      XCTFail()
    }
  }

  /// 메인 페이지 뒤로가기 테스트
  func testPrevious() {
    let viewModel = SignupViewModel(
      mains: [
        MockSignupMain(isBottomDisable: false, title: "A"),
        MockSignupMain(isBottomDisable: true, title: "B"),
        MockSignupMain(isBottomDisable: false, title: "C")
      ],
      tokenManager: self.mockTokenManager
    )
    viewModel.trigger(.next)
    viewModel.trigger(.next)

    viewModel.trigger(.previous)

    if let mock = viewModel.state.currentMain as? MockSignupMain {
      XCTAssertEqual(mock.title, "B")
      XCTAssertTrue(viewModel.state.bottomButton.isDisable)
    } else {
      XCTFail()
    }
  }

  /// 첫 메인 페이지 일 경우, 뒤로 가기 눌렀을 때, SignupView 제거
  func testRemoveSignupViewWhenFirstMainPage() {
    let viewModel = SignupViewModel(
      mains: [
        MockSignupMain(isBottomDisable: false, title: "A")
      ],
      tokenManager: self.mockTokenManager
    )
    AppState.instance.router.set(
      type: MainRoutePath.self,
      paths: [.onboarding, .signup],
      for: RouteKey.main
    )

    viewModel.trigger(.previous)

    XCTAssertEqual(AppState.instance.router.main.count, 1)
    XCTAssertEqual(AppState.instance.router.main.first, .onboarding)
  }

  /// 가입하기
  func testSignup() {
    let expectation = XCTestExpectation(description: "SignupExpectation")
    let viewModel = SignupViewModel(tokenManager: self.mockTokenManager)
    AppState.instance.router.set(
      type: MainRoutePath.self,
      paths: [.onboarding, .signup],
      for: RouteKey.main
    )

    viewModel.trigger(.next)

    viewModel.$state
      .removeDuplicates { lhs, rhs in
        lhs.successSignup == rhs.successSignup
      }
      .sink { [weak self] state in
        guard let `self` = self else { return }
        if state.successSignup {
          XCTAssertEqual(self.mockTokenManager.accessToken(), MockLoginRepository.testToken)
          XCTAssertTrue(AppState.instance.router.main.isEmpty)
          expectation.fulfill()
        }
      }
      .store(in: &self.cancellables)

    wait(for: [expectation], timeout: 5.0)
  }

  /// 가입 통신 에러 알럿 테스트
  func testPresentAlertWhenSignupError() {
    let expectation = XCTestExpectation(description: "SignupErrorExpectation")
    let viewModel = SignupViewModel(tokenManager: self.mockTokenManager)
    self.signupError = MockNetworkError.networkError

    viewModel.trigger(.next)

    viewModel.$state
      .removeDuplicates { lhs, rhs in
        lhs.isPresentAlert == rhs.isPresentAlert
      }
      .sink { [weak self] state in
        guard let `self` = self else { return }
        if state.isPresentAlert {
          XCTAssertNil(self.mockTokenManager.accessToken())
          XCTAssertEqual(
            state.alert.message,
            MockNetworkError.networkError.localizedDescription
          )
          expectation.fulfill()
        }
      }
      .store(in: &self.cancellables)

    wait(for: [expectation], timeout: 5.0)
  }

  /// 로그인 통신 에러 알럿 테스트
  func testPresentAlertWhenLoginError() {
    let expectation = XCTestExpectation(description: "SignupErrorExpectation")
    let viewModel = SignupViewModel(tokenManager: self.mockTokenManager)
    self.loginError = MockNetworkError.networkError

    viewModel.trigger(.next)

    viewModel.$state
      .removeDuplicates { lhs, rhs in
        lhs.isPresentAlert == rhs.isPresentAlert
      }
      .sink { [weak self] state in
        if state.isPresentAlert {
          guard let `self` = self else { return }
          XCTAssertNil(self.mockTokenManager.accessToken())
          XCTAssertFalse(state.successSignup)
          XCTAssertEqual(
            state.alert.message,
            MockNetworkError.networkError.localizedDescription
          )
          expectation.fulfill()
        }
      }
      .store(in: &self.cancellables)

    wait(for: [expectation], timeout: 5.0)
  }
}
