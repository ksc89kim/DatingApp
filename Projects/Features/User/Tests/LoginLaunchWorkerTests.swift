//
//  LoginLaunchWorkerTests.swift
//  UserTests
//
//  Created by kim sunchul on 11/1/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import XCTest
@testable import User
@testable import UserInterface
@testable import Core
@testable import DI
@testable import UserTesting

final class LoginLaunchWorkerTests: XCTestCase {

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

  /// Work 기본 테스트
  func testWork() async throws {
    let tokenManager = MockTokenManager()
    tokenManager.save(token: "START")
    let login = Login(tokenManager: tokenManager)
    let worker = LoginLaunchWorker(loginable: login)

    try await worker.work()

    XCTAssertEqual(tokenManager.accessToken(), MockLoginRepository.testToken)
  }

  /// Work Token Error 테스트
  func testTokenError() async throws {
    let tokenManager = MockTokenManager()
    let login = Login(tokenManager: tokenManager)
    let worker = LoginLaunchWorker(loginable: login)

    try await worker.work()

    XCTAssertNil(tokenManager.accessToken())
  }

  /// Work Repository 에러 (통신 도중 에러가 발새할 경우를 대비)
  func testRepositoryError() async throws {
    self.error = MockNetworkError.networkError
    let tokenManager = MockTokenManager()
    tokenManager.save(token: "START")
    let login = Login(tokenManager: tokenManager)
    let worker = LoginLaunchWorker(loginable: login)

    try await worker.work()

    XCTAssertNil(tokenManager.accessToken())
  }
}
