//
//  MyPageViewModelTests.swift
//  MyPageTests
//
//  Created by kim sunchul on 2/19/26.
//

import XCTest
@testable import DI
@testable import Core
@testable import MyPage
@testable import MyPageInterface
@testable import MyPageTesting
@testable import AppStateInterface

final class MyPageViewModelTests: XCTestCase {

  // MARK: - Property

  private var mockRepository: MockMyPageRepository!

  // MARK: - Setup

  override func setUp() async throws {
    try await super.setUp()

    self.mockRepository = MockMyPageRepository()

    DIContainer.register { [weak self] in
      InjectItem(MyPageRepositoryTypeKey.self) {
        self?.mockRepository ?? MockMyPageRepository()
      }
      InjectItem(AppStateKey.self) {
        AppState.instance
      }
      InjectItem(MyPageRouteKey.self) {
        MyPageRouter()
      }
    }
  }

  // MARK: - loadProfile 성공 테스트

  /// Given: 유효한 프로필 응답이 있을 때
  /// When: loadProfile 액션을 실행하면
  /// Then: 프로필 정보가 State에 반영된다
  func testLoadProfileSuccess() async {
    let viewModel = MyPageViewModel()

    await viewModel.trigger(.loadProfile)

    XCTAssertEqual(viewModel.state.nickname, "테스트유저")
    XCTAssertEqual(viewModel.state.height, "170")
    XCTAssertEqual(viewModel.state.job, "개발자")
    XCTAssertEqual(viewModel.state.introduce, "안녕하세요!")
    XCTAssertEqual(viewModel.state.mbti, "INFJ")
    XCTAssertFalse(viewModel.state.isLoading)
    XCTAssertFalse(viewModel.state.isPresentAlert)
  }

  /// Given: 유효한 생년월일이 있을 때
  /// When: loadProfile 액션을 실행하면
  /// Then: 나이가 계산되어 State에 반영된다
  func testLoadProfileAge() async {
    self.mockRepository.fetchMyProfileResult = .init(
      userID: "test",
      nickname: "테스트",
      profileImageURLs: [],
      birthday: "2000-01-01",
      height: "170",
      job: "개발자",
      gameGenre: [],
      introduce: "",
      mbti: ""
    )
    let viewModel = MyPageViewModel()

    await viewModel.trigger(.loadProfile)

    XCTAssertNotNil(viewModel.state.age)
    XCTAssertGreaterThanOrEqual(viewModel.state.age ?? 0, 25)
  }

  // MARK: - loadProfile 실패 테스트

  /// Given: 네트워크 에러가 발생할 때
  /// When: loadProfile 액션을 실행하면
  /// Then: 에러 알럿이 표시된다
  func testLoadProfileError() async {
    self.mockRepository.fetchMyProfileError = NSError(
      domain: "test",
      code: -1,
      userInfo: [NSLocalizedDescriptionKey: "네트워크 오류"]
    )
    let viewModel = MyPageViewModel()

    await viewModel.trigger(.loadProfile)

    XCTAssertTrue(viewModel.state.isPresentAlert)
    XCTAssertFalse(viewModel.state.alertMessage.isEmpty)
    XCTAssertFalse(viewModel.state.isLoading)
  }

  // MARK: - navigateToEdit 테스트

  /// Given: 마이페이지 홈 화면에서
  /// When: navigateToEdit 액션을 실행하면
  /// Then: myPageRouter의 paths에 .edit이 추가된다
  func testNavigateToEdit() {
    let viewModel = MyPageViewModel()
    let appState = DIContainer.resolve(for: AppStateKey.self) as AppState
    appState.myPageRouter.removeAll()

    viewModel.trigger(.navigateToEdit)

    XCTAssertEqual(appState.myPageRouter.paths, [.edit])
  }

  // MARK: - navigateToSetting 테스트

  /// Given: 마이페이지 홈 화면에서
  /// When: navigateToSetting 액션을 실행하면
  /// Then: myPageRouter의 paths에 .setting이 추가된다
  func testNavigateToSetting() {
    let viewModel = MyPageViewModel()
    let appState = DIContainer.resolve(for: AppStateKey.self) as AppState
    appState.myPageRouter.removeAll()

    viewModel.trigger(.navigateToSetting)

    XCTAssertEqual(appState.myPageRouter.paths, [.setting])
  }

  // MARK: - dismissAlert 테스트

  /// Given: 에러 알럿이 표시된 상태에서
  /// When: dismissAlert 액션을 실행하면
  /// Then: 알럿이 닫힌다
  func testDismissAlert() async {
    self.mockRepository.fetchMyProfileError = NSError(
      domain: "test",
      code: -1,
      userInfo: [NSLocalizedDescriptionKey: "오류"]
    )
    let viewModel = MyPageViewModel()
    await viewModel.trigger(.loadProfile)

    viewModel.trigger(.dismissAlert)

    XCTAssertFalse(viewModel.state.isPresentAlert)
    XCTAssertEqual(viewModel.state.alertMessage, "")
  }

  // MARK: - 초기 상태 테스트

  /// Given: ViewModel을 생성할 때
  /// When: 아무 액션도 실행하지 않으면
  /// Then: 초기 상태값이 올바르다
  func testInitialState() {
    let viewModel = MyPageViewModel()

    XCTAssertEqual(viewModel.state.nickname, "")
    XCTAssertNil(viewModel.state.age)
    XCTAssertEqual(viewModel.state.height, "")
    XCTAssertEqual(viewModel.state.job, "")
    XCTAssertTrue(viewModel.state.profileImageURLs.isEmpty)
    XCTAssertTrue(viewModel.state.gameGenre.isEmpty)
    XCTAssertEqual(viewModel.state.introduce, "")
    XCTAssertEqual(viewModel.state.mbti, "")
    XCTAssertFalse(viewModel.state.isLoading)
    XCTAssertFalse(viewModel.state.isPresentAlert)
  }
}
