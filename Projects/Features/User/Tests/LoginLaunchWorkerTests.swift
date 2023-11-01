//
//  LoginLaunchWorkerTests.swift
//  UserTests
//
//  Created by kim sunchul on 11/1/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import XCTest
import Core
@testable import User
@testable import UserTesting

final class LoginLaunchWorkerTests: XCTestCase {

  /// Work 기본 테스트
  func testWork() async throws {
    let repository = MockLoginRepository()
    let tokenManager = MockTokenManager()
    tokenManager.save(token: "START")
    let login = Login(repository: repository, tokenManager: tokenManager)
    let worker = LoginLaunchWorker(loginable: login)

    try await worker.work()

    XCTAssertEqual(tokenManager.accessToken(), MockLoginRepository.testToken)
  }

  /// Work Token Error 테스트
  func testTokenError() async throws {
    let repository = MockLoginRepository()
    let tokenManager = MockTokenManager()
    let login = Login(repository: repository, tokenManager: tokenManager)
    let worker = LoginLaunchWorker(loginable: login)

    try await worker.work()

    XCTAssertNil(tokenManager.accessToken())
  }

  /// Work Repository 에러 (통신 도중 에러가 발새할 경우를 대비)
  func testRepositoryError() async throws {
    let repository = MockLoginRepository()
    repository.error = MockNetworkError.networkError
    let tokenManager = MockTokenManager()
    tokenManager.save(token: "START")
    let login = Login(repository: repository, tokenManager: tokenManager)
    let worker = LoginLaunchWorker(loginable: login)

    try await worker.work()

    XCTAssertEqual(tokenManager.accessToken(), "START")
  }
}
