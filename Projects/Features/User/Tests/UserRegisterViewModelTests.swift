//
//  UserRegisterViewModelTests.swift
//  UserTests
//
//  Created by kim sunchul on 2/13/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import XCTest
@testable import DI
@testable import Core
@testable import User
@testable import UserInterface
@testable import UserTesting
@testable import Util

final class UserRegisterViewModelTests: XCTestCase {
  
  // MARK: - Method
  
  override func setUp() async throws {
    try await super.setUp()
    
    DIContainer.register {
      InjectItem(UserRegisterRepositoryTypeKey.self) {
        MockUserRegisterRepository()
      }
    }
  }
  
  /// UI 초기화
  func testInitUI() async {
    let viewModel = UserRegisterViewModel(
      container: .init(
        index: 0,
        mains: [
          MockUserRegisterMain(isBottomDisable: false, title: "A"),
          MockUserRegisterMain(isBottomDisable: false, title: "B")
        ]
      )
    )
    
    await viewModel.trigger(.initUI)
    
    if let mock = viewModel.state.currentMain as? MockUserRegisterMain {
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
    let viewModel = UserRegisterViewModel(container: .init(index: 0, mains: []))
    
    XCTAssertNil(viewModel.state.currentMain)
  }
  
  
  /// 메인 페이지 다음
  func testNext() async {
    let viewModel = UserRegisterViewModel(
      container: .init(
        index: 0,
        mains: [
          MockUserRegisterMain(isBottomDisable: false, title: "A"),
          MockUserRegisterMain(isBottomDisable: false, title: "B"),
          MockUserRegisterMain(isBottomDisable: true, title: "C")
        ]
      )
    )
    
    await viewModel.trigger(.next)
    await viewModel.trigger(.next)
    
    if let mock = viewModel.state.currentMain as? MockUserRegisterMain {
      XCTAssertEqual(mock.title, "C")
      XCTAssertTrue(viewModel.state.bottomButton.isDisable)
    } else {
      XCTFail()
    }
  }
  
  /// 메인 페이지 뒤로가기
  func testPrevious() async {
    let viewModel = UserRegisterViewModel(
      container: .init(
        index: 0,
        mains: [
          MockUserRegisterMain(isBottomDisable: false, title: "A"),
          MockUserRegisterMain(isBottomDisable: true, title: "B"),
          MockUserRegisterMain(isBottomDisable: false, title: "C")
        ]
      )
    )
    await viewModel.trigger(.next)
    await viewModel.trigger(.next)
    
    await viewModel.trigger(.previous)
    
    if let mock = viewModel.state.currentMain as? MockUserRegisterMain {
      XCTAssertEqual(mock.title, "B")
      XCTAssertTrue(viewModel.state.bottomButton.isDisable)
    } else {
      XCTFail()
    }
  }
  
  /// 창 닫기
  func testDismiss() async {
    let viewModel = UserRegisterViewModel(
      container: .init(
        index: 0,
        mains: [
          MockUserRegisterMain(isBottomDisable: false, title: "A")
        ]
      )
    )
    
    await viewModel.trigger(.previous)
    
    XCTAssertTrue(viewModel.state.shouldDismiss)
  }
  
  /// 생년월일 설정
  func testSetBirthday() async {
    let date: Date = .now
    let viewModel = UserRegisterViewModel(
      container: .init(
        index: 0,
        mains: [
          UserRegisterBirthday(birthday: date)
        ]
      )
    )
    await viewModel.trigger(.initUI)
    let birthday = date.addingTimeInterval(10000)
    
    await viewModel.trigger(.birthday(birthday))
    
    if let userRegisterBirthday = viewModel.state.currentMain as? UserRegisterBirthday {
      XCTAssertEqual(userRegisterBirthday.birthday, birthday)
      XCTAssertFalse(viewModel.state.bottomButton.isDisable)
    } else {
      XCTFail()
    }
  }
  
  /// 키높이 설정
  func testSetHeight() async {
    let viewModel = UserRegisterViewModel(
      container: .init(
        index: 0,
        mains: [
          UserRegisterHeight(height: "100cm")
        ]
      )
    )
    await viewModel.trigger(.initUI)
    
    await viewModel.trigger(.height("177cm"))
    
    if let userRegisterHeight = viewModel.state.currentMain as? UserRegisterHeight {
      XCTAssertEqual(userRegisterHeight.height, "177cm")
      XCTAssertFalse(viewModel.state.bottomButton.isDisable)
    } else {
      XCTFail()
    }
  }
  
  /// 태그 하나 선택 설정
  func testSingleSelect() async {
    let viewModel = UserRegisterViewModel(
      container: .init(
        index: 0,
        mains: [
          UserRegisterSingleSelect(key: "test", title: "설정")
        ]
      )
    )
    await viewModel.trigger(.initUI)
    
    await viewModel.trigger(.singleSelect(key: "test", value: "테스트1"))
    
    if let userRegisterSingleSelect = viewModel.state.currentMain as? UserRegisterSingleSelect {
      XCTAssertEqual(userRegisterSingleSelect.selection, "테스트1")
      XCTAssertFalse(viewModel.state.bottomButton.isDisable)
    } else {
      XCTFail()
    }
  }
  
  /// 태그 하나 선택에서 설정 안 했을 때 바텀 Disable. 테스트
  func testBottomButtonIsDisabledWhenNoSingleSelected() async {
    let viewModel = UserRegisterViewModel(
      container: .init(
        index: 0,
        mains: [
          UserRegisterSingleSelect(key: "test", title: "설정")
        ]
      )
    )
    await viewModel.trigger(.initUI)
    
    if let userRegisterSingleSelect = viewModel.state.currentMain as? UserRegisterSingleSelect {
      XCTAssertNil(userRegisterSingleSelect.selection)
      XCTAssertTrue(viewModel.state.bottomButton.isDisable)
    } else {
      XCTFail()
    }
  }
  
  /// 태그 여러개 선택 설정
  func testMultipleSelect() async {
    let viewModel = UserRegisterViewModel(
      container: .init(
        index: 0,
        mains: [
          UserRegisterMultipleSelect(
            key: "test",
            title: "설정",
            selections: [
            ]
          )
        ]
      )
    )
    
    await viewModel.trigger(.initUI)
    
    let selections: Set<Chip> = [.init(key: "A", title: "A")]
    await viewModel.trigger(.multipleSelect(key: "test", value: selections))
    
    if let userRegisterMultipleSelect = viewModel.state.currentMain as? UserRegisterMultipleSelect {
      XCTAssertEqual(userRegisterMultipleSelect.selections, selections)
      XCTAssertFalse(viewModel.state.bottomButton.isDisable)
    } else {
      XCTFail()
    }
  }
  
  /// 이미지 피커 보여주기
  func testShowAlbum() async {
    let viewModel = UserRegisterViewModel(
      container: .init(
        index: 0,
        mains: [
          UserRegisterGallery()
        ]
      )
    )
    
    await viewModel.trigger(.initUI)
    
    await viewModel.trigger(.showAlbum)
    
    XCTAssertTrue(viewModel.state.showingImagePicker)
  }
  
  /// 이미지 피커 숨기기
  func testHideAlbum() async {
    let viewModel = UserRegisterViewModel(
      container: .init(
        index: 0,
        mains: []
      )
    )
    
    await viewModel.trigger(.initUI)
    
    await viewModel.trigger(.hideAlbum)
    
    XCTAssertFalse(viewModel.state.showingImagePicker)
  }
  
  /// 첫번째 이미지 추가
  func testInsertFirstImage() async {
    let viewModel = UserRegisterViewModel(
      container: .init(
        index: 0,
        mains: [
          UserRegisterGallery()
        ]
      )
    )
    
    await viewModel.trigger(.initUI)
    
    await viewModel.trigger(.selectedImage(image: UIImage(systemName: "square.and.arrow.up")))
    
    if let userRegisterGallery = viewModel.state.currentMain as? UserRegisterGallery {
      XCTAssertNotNil(userRegisterGallery.firstImage)
      XCTAssertNil(userRegisterGallery.secondImage)
      XCTAssertTrue(viewModel.state.bottomButton.isDisable)
    } else {
      XCTFail()
    }
  }
  
  /// 두번째 이미지 추가
  func testInsertSecondImage() async {
    let viewModel = UserRegisterViewModel(
      container: .init(
        index: 0,
        mains: [
          UserRegisterGallery()
        ]
      )
    )
    
    await viewModel.trigger(.initUI)
    
    await viewModel.trigger(.selectedImage(image: UIImage(systemName: "square.and.arrow.up")))
    await viewModel.trigger(.selectedImage(image: UIImage(systemName: "square.and.arrow.up")))
    
    if let userRegisterGallery = viewModel.state.currentMain as? UserRegisterGallery {
      XCTAssertNotNil(userRegisterGallery.firstImage)
      XCTAssertNotNil(userRegisterGallery.secondImage)
      XCTAssertFalse(viewModel.state.bottomButton.isDisable)
    } else {
      XCTFail()
    }
  }
  
  /// 이미지 삭제
  func testDeleteImage() async {
    let viewModel = UserRegisterViewModel(
      container: .init(
        index: 0,
        mains: [
          UserRegisterGallery()
        ]
      )
    )
    
    await viewModel.trigger(.initUI)
    
    await viewModel.trigger(.selectedImage(image: UIImage(systemName: "square.and.arrow.up")))
    await viewModel.trigger(.selectedImage(image: UIImage(systemName: "square.and.arrow.up")))
    await viewModel.trigger(.deleteImage(index: .first))

    if let userRegisterGallery = viewModel.state.currentMain as? UserRegisterGallery {
      XCTAssertNotNil(userRegisterGallery.firstImage)
      XCTAssertNil(userRegisterGallery.secondImage)
      XCTAssertTrue(viewModel.state.bottomButton.isDisable)
    } else {
      XCTFail()
    }
  }
}
