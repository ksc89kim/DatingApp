//
//  OnboardingViewModelTests.swift
//  OnboardingTests
//
//  Created by kim sunchul on 11/16/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import XCTest
@testable import DI
@testable import Onboarding
@testable import AppStateInterface

final class OnboardingViewModelTests: XCTestCase {

  // MARK: - Method

  override func setUp() {
    super.setUp()

    AppStateDIRegister.register()
  }

  /// 가입하기로 이동
  func testPresentSignup() {
    let viewModel = OnboardingViewModel()

    viewModel.trigger(.presentSignup)

    XCTAssertEqual(AppState.instance.entranceRouter.count, 1)
    XCTAssertEqual(AppState.instance.entranceRouter.first, .signup)
  }
}
