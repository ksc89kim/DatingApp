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

  private var signupError: Error?

  private var loginError: Error?

  private var mockTokenManager: MockTokenManager!

  // MARK: - Method

  override func setUp() async throws {
    try await super.setUp()

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
  func testInitUI() async {
    let viewModel = SignupViewModel(
      mains: [
        MockSignupMain(isBottomDisable: false, title: "A"),
        MockSignupMain(isBottomDisable: false, title: "B")
      ],
      tokenManager: self.mockTokenManager
    )

    await viewModel.trigger(.initUI)

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
  func testSetNickname() async {
    let viewModel = SignupViewModel(
      mains: [SignupNickname()],
      tokenManager: self.mockTokenManager
    )
    await viewModel.trigger(.initUI)

    await viewModel.trigger(.nickname("테스트"))

    if let nickname = viewModel.state.currentMain as? SignupNickname {
      XCTAssertEqual(nickname.nickname, "테스트")
      XCTAssertFalse(viewModel.state.bottomButton.isDisable)
    } else {
      XCTFail()
    }
  }

  /// 닉네임 0자 일때, 바텀 버튼 disable
  func testDisableBottomButtonWhenNoNickname() async {
    let viewModel = SignupViewModel(
      mains: [SignupNickname()],
      tokenManager: self.mockTokenManager
    )

    await viewModel.trigger(.initUI)

    if let nickname = viewModel.state.currentMain as? SignupNickname {
      XCTAssertTrue(nickname.nickname.isEmpty)
      XCTAssertTrue(viewModel.state.bottomButton.isDisable)
    } else {
      XCTFail()
    }
  }

  /// 메인 페이지 다음 테스트
  func testNext() async {
    let viewModel = SignupViewModel(
      mains: [
        MockSignupMain(isBottomDisable: false, title: "A"),
        MockSignupMain(isBottomDisable: false, title: "B"),
        MockSignupMain(isBottomDisable: true, title: "C")
      ],
      tokenManager: self.mockTokenManager
    )

    await viewModel.trigger(.next)
    await viewModel.trigger(.next)

    if let mock = viewModel.state.currentMain as? MockSignupMain {
      XCTAssertEqual(mock.title, "C")
      XCTAssertTrue(viewModel.state.bottomButton.isDisable)
    } else {
      XCTFail()
    }
  }

  /// 메인 페이지 뒤로가기 테스트
  func testPrevious() async {
    let viewModel = SignupViewModel(
      mains: [
        MockSignupMain(isBottomDisable: false, title: "A"),
        MockSignupMain(isBottomDisable: true, title: "B"),
        MockSignupMain(isBottomDisable: false, title: "C")
      ],
      tokenManager: self.mockTokenManager
    )
    await viewModel.trigger(.next)
    await viewModel.trigger(.next)

    await viewModel.trigger(.previous)

    if let mock = viewModel.state.currentMain as? MockSignupMain {
      XCTAssertEqual(mock.title, "B")
      XCTAssertTrue(viewModel.state.bottomButton.isDisable)
    } else {
      XCTFail()
    }
  }

  /// 첫 메인 페이지 일 경우, 뒤로 가기 눌렀을 때, SignupView 제거
  func testRemoveSignupViewWhenFirstMainPage() async {
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

    await viewModel.trigger(.previous)

    XCTAssertEqual(AppState.instance.router.main.count, 1)
    XCTAssertEqual(AppState.instance.router.main.first, .onboarding)
  }

  /// 가입하기
  func testSignup() async {
    let viewModel = SignupViewModel(tokenManager: self.mockTokenManager)
    AppState.instance.router.set(
      type: MainRoutePath.self,
      paths: [.onboarding, .signup],
      for: RouteKey.main
    )

    await viewModel.trigger(.next)

    XCTAssertTrue(viewModel.state.successSignup)
    XCTAssertEqual(self.mockTokenManager.accessToken(), MockLoginRepository.testToken)
    XCTAssertTrue(AppState.instance.router.main.isEmpty)
  }

  /// 가입 통신 에러 알럿 테스트
  func testPresentAlertWhenSignupError() async {
    self.signupError = MockNetworkError.networkError
    let viewModel = SignupViewModel(tokenManager: self.mockTokenManager)

    await viewModel.trigger(.next)

    XCTAssertTrue(viewModel.state.isPresentAlert)
    XCTAssertFalse(viewModel.state.successSignup)
    XCTAssertNil(self.mockTokenManager.accessToken())
    XCTAssertEqual(
      viewModel.state.alert.message,
      MockNetworkError.networkError.localizedDescription
    )
  }

  /// 로그인 통신 에러 알럿 테스트
  func testPresentAlertWhenLoginError() async {
    self.loginError = MockNetworkError.networkError
    let viewModel = SignupViewModel(tokenManager: self.mockTokenManager)

    await viewModel.trigger(.next)

    XCTAssertTrue(viewModel.state.isPresentAlert)
    XCTAssertFalse(viewModel.state.successSignup)
    XCTAssertNil(self.mockTokenManager.accessToken())
    XCTAssertEqual(
      viewModel.state.alert.message,
      MockNetworkError.networkError.localizedDescription
    )
  }
}
