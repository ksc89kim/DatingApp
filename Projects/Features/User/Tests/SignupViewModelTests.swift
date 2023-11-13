//
//  SignupViewModelTests.swift
//  UserTests
//
//  Created by kim sunchul on 11/12/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import XCTest
@testable import User
@testable import UserTesting

final class SignupViewModelTests: XCTestCase {

  /// UI 초기화
  func testInitUI() {
    let viewModel = SignupViewModel(mains: [
      MockSignupMain(isBottomDisable: false, title: "A"),
      MockSignupMain(isBottomDisable: false, title: "B")
    ])

    viewModel.trigger(.initUI)

    if let mock = viewModel.state.currentMain as? MockSignupMain {
      XCTAssertEqual(mock.title, "A")
      XCTAssertFalse(viewModel.state.isBottmButtonDisable)
      XCTAssertEqual(viewModel.state.progressValue, 0.5)
      XCTAssertFalse(viewModel.state.isProgressViewAnimation)
    } else {
      XCTFail()
    }
  }

  /// 초기화가 진행되지 않을 경우 Main nill 확인
  func testCurrentMainNil() {
    let viewModel = SignupViewModel()

    XCTAssertNil(viewModel.state.currentMain)
  }

  /// 닉네임 설정 테스트
  func testSetNickname() {
    let viewModel = SignupViewModel()
    viewModel.trigger(.initUI)

    viewModel.trigger(.nickname("테스트"))

    if let nickname = viewModel.state.currentMain as? SignupNickname {
      XCTAssertEqual(nickname.nickname, "테스트")
      XCTAssertFalse(viewModel.state.isBottmButtonDisable)
    } else {
      XCTFail()
    }
  }

  /// 닉네임 0자 일때, 바텀 버튼 disable
  func testDisableBottomButtonWhenNoNickname() {
    let viewModel = SignupViewModel()

    viewModel.trigger(.initUI)

    if let nickname = viewModel.state.currentMain as? SignupNickname {
      XCTAssertTrue(nickname.nickname.isEmpty)
      XCTAssertTrue(viewModel.state.isBottmButtonDisable)
    } else {
      XCTFail()
    }
  }

  /// 다음
  func testNext() {
    let viewModel = SignupViewModel(mains: [
      MockSignupMain(isBottomDisable: false, title: "A"),
      MockSignupMain(isBottomDisable: false, title: "B"),
      MockSignupMain(isBottomDisable: true, title: "C")
    ])

    viewModel.trigger(.next)
    viewModel.trigger(.next)

    if let mock = viewModel.state.currentMain as? MockSignupMain {
      XCTAssertEqual(mock.title, "C")
      XCTAssertTrue(viewModel.state.isBottmButtonDisable)
    } else {
      XCTFail()
    }
  }

  /// 이전
  func testPrevious() {
    let viewModel = SignupViewModel(mains: [
      MockSignupMain(isBottomDisable: false, title: "A"),
      MockSignupMain(isBottomDisable: true, title: "B"),
      MockSignupMain(isBottomDisable: false, title: "C")
    ])
    viewModel.trigger(.next)
    viewModel.trigger(.next)

    viewModel.trigger(.previous)

    if let mock = viewModel.state.currentMain as? MockSignupMain {
      XCTAssertEqual(mock.title, "B")
      XCTAssertTrue(viewModel.state.isBottmButtonDisable)
    } else {
      XCTFail()
    }
  }
}
