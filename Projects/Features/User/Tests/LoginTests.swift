//
//  LoginTests.swift
//  UserTests
//
//  Created by kim sunchul on 10/31/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import XCTest
@testable import Core
@testable import User
@testable import UserInterface
@testable import UserTesting
@testable import DI

final class LoginTests: XCTestCase {

  // MARK: - Property

  private var error: Error?

  // MARK: - Method

  override func setUp() async throws {
    try await super.setUp()

    self.error = nil

    DIContainer.register { [weak self] in
      InjectItem(LoginRepositoryTypeKey.self) {
        let repository = MockLoginRepository()
        repository.error = self?.error
        return repository
      }
    }
  }

  /// 로그인 성공 테스트
  func testLogin() async throws {
    let tokenManager = MockTokenManager()
    let login = Login(tokenManager: tokenManager)
    tokenManager.save(token: "ABCD")

    try await login.login()

    XCTAssertEqual(tokenManager.accessToken(), MockLoginRepository.testToken)
  }

  /// 로그인 토큰이 없을 경우 에러 확인
  func testTokenError() async {
    let tokenManager = MockTokenManager()
    let login = Login(tokenManager: tokenManager)

    do {
      try await login.login()
      XCTFail()
    } catch {
      XCTAssertEqual(tokenManager.accessToken(), nil)
    }
  }

  /// 로그인 Repository 에러 (통신 도중 에러가 발새할 경우를 대비)
  func testRepositoryError() async {
    self.error = MockNetworkError.networkError
    let tokenManager = MockTokenManager()
    let login = Login(tokenManager: tokenManager)

    tokenManager.save(token: "ABCD")

    do {
      try await login.login()
      XCTFail()
    } catch {
      if let error = error as? MockNetworkError {
        XCTAssertEqual(tokenManager.accessToken(), nil)
        XCTAssertEqual(error, MockNetworkError.networkError)
      } else {
        XCTFail()
      }
    }
  }
}
