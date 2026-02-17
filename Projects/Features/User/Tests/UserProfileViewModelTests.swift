//
//  UserProfileViewModelTests.swift
//  UserTests
//
//  Created by kim sunchul on 2/13/26.
//

import XCTest
@testable import DI
@testable import Core
@testable import User
@testable import UserInterface
@testable import UserTesting
@testable import Util
@testable import AppStateInterface

final class UserProfileViewModelTests: XCTestCase {

  // MARK: - Property

  private var mockRepository: MockUserProfileRepository!

  private var profileError: Error?

  // MARK: - Method

  override func setUp() async throws {
    try await super.setUp()

    self.profileError = nil
    self.mockRepository = MockUserProfileRepository()

    AppStateDIRegister.register()
    AppState.instance.chatRouter.removeAll()

    DIContainer.register { [weak self] in
      InjectItem(UserProfileRepositoryTypeKey.self) {
        let repository = self?.mockRepository ?? MockUserProfileRepository()
        repository.error = self?.profileError
        return repository
      }
    }
  }

  // MARK: - loadProfile 성공 테스트

  /// Given: 유효한 프로필 응답이 있을 때
  /// When: loadProfile 액션을 실행하면
  /// Then: 프로필 정보가 State에 반영된다
  func testLoadProfileSuccess() async {
    let response = Self.makeProfileResponse()
    self.mockRepository.fetchProfileResponse = response
    let viewModel = self.makeViewModel()

    await viewModel.trigger(.loadProfile)

    XCTAssertEqual(viewModel.state.nickname, "테스터")
    XCTAssertEqual(viewModel.state.height, "175cm")
    XCTAssertEqual(viewModel.state.job, "개발자")
    XCTAssertEqual(viewModel.state.introduce, "안녕하세요")
    XCTAssertEqual(viewModel.state.mbti, "INTJ")
    XCTAssertFalse(viewModel.state.isLoading)
    XCTAssertNil(viewModel.state.errorMessage)
  }

  /// Given: 프로필 이미지 URL 목록이 있을 때
  /// When: loadProfile 액션을 실행하면
  /// Then: 유효한 URL만 profileImageURLs에 반영된다
  func testLoadProfileImageURLs() async {
    let response = Self.makeProfileResponse(
      profileImages: [
        "https://example.com/image1.jpg",
        "https://example.com/image2.jpg",
        ""
      ]
    )
    self.mockRepository.fetchProfileResponse = response
    let viewModel = self.makeViewModel()

    await viewModel.trigger(.loadProfile)

    XCTAssertEqual(viewModel.state.profileImageURLs.count, 2)
    XCTAssertEqual(
      viewModel.state.profileImageURLs.first?.absoluteString,
      "https://example.com/image1.jpg"
    )
  }

  /// Given: 게임 장르가 포함된 프로필 응답이 있을 때
  /// When: loadProfile 액션을 실행하면
  /// Then: gameGenreChips가 올바르게 생성된다
  func testLoadProfileGameGenreChips() async {
    let response = Self.makeProfileResponse(
      gameGenre: ["RPG", "FPS", "전략"]
    )
    self.mockRepository.fetchProfileResponse = response
    let viewModel = self.makeViewModel()

    await viewModel.trigger(.loadProfile)

    XCTAssertEqual(viewModel.state.gameGenreChips.count, 3)
    XCTAssertEqual(viewModel.state.gameGenreChips[0].key, "RPG")
    XCTAssertEqual(viewModel.state.gameGenreChips[1].key, "FPS")
    XCTAssertEqual(viewModel.state.gameGenreChips[2].key, "전략")
  }

  /// Given: 게임 장르가 포함된 프로필 응답이 있을 때
  /// When: loadProfile 액션을 실행하면
  /// Then: gameGenreSelections가 chips와 동일한 Set으로 설정된다
  func testLoadProfileGameGenreSelections() async {
    let response = Self.makeProfileResponse(
      gameGenre: ["RPG", "FPS"]
    )
    self.mockRepository.fetchProfileResponse = response
    let viewModel = self.makeViewModel()

    await viewModel.trigger(.loadProfile)

    XCTAssertEqual(
      viewModel.state.gameGenreSelections.count,
      viewModel.state.gameGenreChips.count
    )
    for chip in viewModel.state.gameGenreChips {
      XCTAssertTrue(
        viewModel.state.gameGenreSelections.contains(chip)
      )
    }
  }

  /// Given: 유효한 생년월일(yyyy-MM-dd)이 있을 때
  /// When: loadProfile 액션을 실행하면
  /// Then: 나이가 계산되어 State에 반영된다
  func testLoadProfileAge() async {
    let response = Self.makeProfileResponse(birthday: "2000-01-01")
    self.mockRepository.fetchProfileResponse = response
    let viewModel = self.makeViewModel()

    await viewModel.trigger(.loadProfile)

    XCTAssertNotNil(viewModel.state.age)
    XCTAssertGreaterThanOrEqual(viewModel.state.age ?? 0, 25)
  }

  /// Given: 잘못된 생년월일 형식이 있을 때
  /// When: loadProfile 액션을 실행하면
  /// Then: 나이가 nil이다
  func testLoadProfileInvalidBirthday() async {
    let response = Self.makeProfileResponse(birthday: "invalid-date")
    self.mockRepository.fetchProfileResponse = response
    let viewModel = self.makeViewModel()

    await viewModel.trigger(.loadProfile)

    XCTAssertNil(viewModel.state.age)
  }

  // MARK: - loadProfile 실패 테스트

  /// Given: 네트워크 에러가 발생할 때
  /// When: loadProfile 액션을 실행하면
  /// Then: errorMessage가 설정된다
  func testLoadProfileError() async {
    self.profileError = MockNetworkError.networkError
    let viewModel = self.makeViewModel()

    await viewModel.trigger(.loadProfile)

    XCTAssertNotNil(viewModel.state.errorMessage)
    XCTAssertEqual(
      viewModel.state.errorMessage,
      MockNetworkError.networkError.localizedDescription
    )
    XCTAssertFalse(viewModel.state.isLoading)
  }

  // MARK: - loadProfile Repository 호출 검증

  /// Given: 특정 userID로 ViewModel을 생성했을 때
  /// When: loadProfile 액션을 실행하면
  /// Then: Repository의 fetchProfile이 해당 userID로 호출된다
  func testLoadProfileCallsRepositoryWithCorrectUserID() async {
    let response = Self.makeProfileResponse()
    self.mockRepository.fetchProfileResponse = response
    let viewModel = self.makeViewModel(userID: "user456")

    await viewModel.trigger(.loadProfile)

    XCTAssertEqual(self.mockRepository.fetchProfileCallCount, 1)
    XCTAssertEqual(
      self.mockRepository.lastFetchedUserID,
      "user456"
    )
  }

  // MARK: - swipeImage 테스트

  /// Given: 프로필 화면이 표시된 상태에서
  /// When: 이미지를 스와이프하면
  /// Then: currentImageIndex가 업데이트된다
  func testSwipeImage() async {
    let viewModel = self.makeViewModel()

    await viewModel.trigger(.swipeImage(index: 2))

    XCTAssertEqual(viewModel.state.currentImageIndex, 2)
  }

  /// Given: 이미지 인덱스가 0인 상태에서
  /// When: 인덱스 0으로 스와이프하면
  /// Then: currentImageIndex가 0으로 유지된다
  func testSwipeImageToZero() async {
    let viewModel = self.makeViewModel()

    await viewModel.trigger(.swipeImage(index: 0))

    XCTAssertEqual(viewModel.state.currentImageIndex, 0)
  }

  // MARK: - like 테스트

  /// Given: 프로필이 로드된 상태에서
  /// When: like 액션을 실행하면
  /// Then: didLike가 true이고 화면이 닫힌다
  func testLikeSuccess() async {
    let viewModel = self.makeViewModel(userID: "user123")

    await viewModel.trigger(.like)

    XCTAssertTrue(viewModel.state.didLike)
    XCTAssertTrue(viewModel.state.shouldDismiss)
    XCTAssertFalse(viewModel.state.isPresentAlert)
  }

  /// Given: like 액션을 실행할 때
  /// When: Repository에 올바른 userID가 전달되면
  /// Then: likedUserIDs에 해당 userID가 추가된다
  func testLikeCallsRepositoryWithCorrectUserID() async {
    let viewModel = self.makeViewModel(userID: "user789")

    await viewModel.trigger(.like)

    XCTAssertEqual(self.mockRepository.likeCallCount, 1)
    XCTAssertEqual(
      self.mockRepository.lastLikedUserID,
      "user789"
    )
    XCTAssertTrue(
      self.mockRepository.likedUserIDs.contains("user789")
    )
  }

  /// Given: 네트워크 에러가 발생할 때
  /// When: like 액션을 실행하면
  /// Then: 에러 알럿이 표시되고 화면이 닫히지 않는다
  func testLikeError() async {
    self.profileError = MockNetworkError.networkError
    let viewModel = self.makeViewModel()

    await viewModel.trigger(.like)

    XCTAssertFalse(viewModel.state.didLike)
    XCTAssertFalse(viewModel.state.shouldDismiss)
    XCTAssertTrue(viewModel.state.isPresentAlert)
    XCTAssertEqual(
      viewModel.state.alert.message,
      MockNetworkError.networkError.localizedDescription
    )
  }

  // MARK: - skip 테스트

  /// Given: 프로필이 로드된 상태에서
  /// When: skip 액션을 실행하면
  /// Then: didSkip이 true이고 화면이 닫힌다
  func testSkipSuccess() async {
    let viewModel = self.makeViewModel(userID: "user123")

    await viewModel.trigger(.skip)

    XCTAssertTrue(viewModel.state.didSkip)
    XCTAssertTrue(viewModel.state.shouldDismiss)
    XCTAssertFalse(viewModel.state.isPresentAlert)
  }

  /// Given: skip 액션을 실행할 때
  /// When: Repository에 올바른 userID가 전달되면
  /// Then: skippedUserIDs에 해당 userID가 추가된다
  func testSkipCallsRepositoryWithCorrectUserID() async {
    let viewModel = self.makeViewModel(userID: "user321")

    await viewModel.trigger(.skip)

    XCTAssertEqual(self.mockRepository.skipCallCount, 1)
    XCTAssertEqual(
      self.mockRepository.lastSkippedUserID,
      "user321"
    )
    XCTAssertTrue(
      self.mockRepository.skippedUserIDs.contains("user321")
    )
  }

  /// Given: 네트워크 에러가 발생할 때
  /// When: skip 액션을 실행하면
  /// Then: 에러 알럿이 표시되고 화면이 닫히지 않는다
  func testSkipError() async {
    self.profileError = MockNetworkError.networkError
    let viewModel = self.makeViewModel()

    await viewModel.trigger(.skip)

    XCTAssertFalse(viewModel.state.didSkip)
    XCTAssertFalse(viewModel.state.shouldDismiss)
    XCTAssertTrue(viewModel.state.isPresentAlert)
    XCTAssertEqual(
      viewModel.state.alert.message,
      MockNetworkError.networkError.localizedDescription
    )
  }

  // MARK: - back 테스트

  /// Given: 프로필 화면이 표시된 상태에서
  /// When: back 액션을 실행하면
  /// Then: shouldDismiss가 true가 된다
  func testBack() async {
    let viewModel = self.makeViewModel()

    await viewModel.trigger(.back)

    XCTAssertTrue(viewModel.state.shouldDismiss)
    XCTAssertFalse(viewModel.state.didLike)
    XCTAssertFalse(viewModel.state.didSkip)
  }

  // MARK: - entryType 테스트

  /// Given: matchRecommend 진입 경로로 생성할 때
  /// When: ViewModel이 초기화되면
  /// Then: entryType이 matchRecommend이다
  func testEntryTypeMatchRecommend() {
    let viewModel = self.makeViewModel(
      entryType: .matchRecommend
    )

    XCTAssertEqual(
      viewModel.state.entryType,
      UserProfileEntryType.matchRecommend
    )
  }

  /// Given: chatList 진입 경로로 생성할 때
  /// When: ViewModel이 초기화되면
  /// Then: entryType이 chatList이다
  func testEntryTypeChatList() {
    let viewModel = self.makeViewModel(entryType: .chatList)

    XCTAssertEqual(
      viewModel.state.entryType,
      UserProfileEntryType.chatList
    )
  }

  /// Given: myPage 진입 경로로 생성할 때
  /// When: ViewModel이 초기화되면
  /// Then: entryType이 myPage이다
  func testEntryTypeMyPage() {
    let viewModel = self.makeViewModel(entryType: .myPage)

    XCTAssertEqual(
      viewModel.state.entryType,
      UserProfileEntryType.myPage
    )
  }

  // MARK: - 초기 상태 테스트

  /// Given: ViewModel을 생성할 때
  /// When: 아무 액션도 실행하지 않으면
  /// Then: 초기 상태값이 올바르다
  func testInitialState() {
    let viewModel = self.makeViewModel()

    XCTAssertEqual(viewModel.state.nickname, "")
    XCTAssertNil(viewModel.state.age)
    XCTAssertEqual(viewModel.state.height, "")
    XCTAssertEqual(viewModel.state.job, "")
    XCTAssertEqual(viewModel.state.introduce, "")
    XCTAssertEqual(viewModel.state.mbti, "")
    XCTAssertTrue(viewModel.state.profileImageURLs.isEmpty)
    XCTAssertTrue(viewModel.state.gameGenreChips.isEmpty)
    XCTAssertTrue(viewModel.state.gameGenreSelections.isEmpty)
    XCTAssertEqual(viewModel.state.currentImageIndex, 0)
    XCTAssertFalse(viewModel.state.isLoading)
    XCTAssertFalse(viewModel.state.isPresentAlert)
    XCTAssertFalse(viewModel.state.shouldDismiss)
    XCTAssertFalse(viewModel.state.didLike)
    XCTAssertFalse(viewModel.state.didSkip)
    XCTAssertFalse(viewModel.state.didReport)
    XCTAssertFalse(viewModel.state.didBlock)
    XCTAssertNil(viewModel.state.errorMessage)
  }

  // MARK: - report 테스트

  /// Given: 프로필이 로드된 상태에서
  /// When: report 액션을 실행하면
  /// Then: didReport가 true이고 화면이 닫힌다
  func testReportSuccess() async {
    let viewModel = self.makeViewModel(userID: "user123")

    await viewModel.trigger(.report)

    XCTAssertTrue(viewModel.state.didReport)
    XCTAssertTrue(viewModel.state.shouldDismiss)
    XCTAssertFalse(viewModel.state.isPresentAlert)
    XCTAssertEqual(self.mockRepository.reportCallCount, 1)
    XCTAssertEqual(
      self.mockRepository.lastReportedUserID,
      "user123"
    )
  }

  /// Given: 네트워크 에러가 발생할 때
  /// When: report 액션을 실행하면
  /// Then: 에러 알럿이 표시되고 화면이 닫히지 않는다
  func testReportError() async {
    self.profileError = MockNetworkError.networkError
    let viewModel = self.makeViewModel()

    await viewModel.trigger(.report)

    XCTAssertFalse(viewModel.state.didReport)
    XCTAssertFalse(viewModel.state.shouldDismiss)
    XCTAssertTrue(viewModel.state.isPresentAlert)
    XCTAssertEqual(
      viewModel.state.alert.message,
      MockNetworkError.networkError.localizedDescription
    )
  }

  // MARK: - block 테스트

  /// Given: 프로필이 로드된 상태에서
  /// When: block 액션을 실행하면
  /// Then: didBlock이 true이고 화면이 닫힌다
  func testBlockSuccess() async {
    let viewModel = self.makeViewModel(userID: "user123")

    await viewModel.trigger(.block)

    XCTAssertTrue(viewModel.state.didBlock)
    XCTAssertTrue(viewModel.state.shouldDismiss)
    XCTAssertFalse(viewModel.state.isPresentAlert)
    XCTAssertEqual(self.mockRepository.blockCallCount, 1)
    XCTAssertEqual(
      self.mockRepository.lastBlockedUserID,
      "user123"
    )
  }

  /// Given: 네트워크 에러가 발생할 때
  /// When: block 액션을 실행하면
  /// Then: 에러 알럿이 표시되고 화면이 닫히지 않는다
  func testBlockError() async {
    self.profileError = MockNetworkError.networkError
    let viewModel = self.makeViewModel()

    await viewModel.trigger(.block)

    XCTAssertFalse(viewModel.state.didBlock)
    XCTAssertFalse(viewModel.state.shouldDismiss)
    XCTAssertTrue(viewModel.state.isPresentAlert)
    XCTAssertEqual(
      viewModel.state.alert.message,
      MockNetworkError.networkError.localizedDescription
    )
  }

  // MARK: - openChat 테스트

  /// Given: 프로필 화면이 표시된 상태에서
  /// When: openChat 액션을 실행하면
  /// Then: chatRouter에 chatRoom 경로가 추가되고 화면이 닫힌다
  func testOpenChat() async {
    let viewModel = self.makeViewModel(userID: "user123")

    await viewModel.trigger(.openChat)

    let firstPath = AppState.instance.chatRouter.paths.first
    XCTAssertEqual(firstPath, .chatRoom(idx: "user123"))
    XCTAssertTrue(viewModel.state.shouldDismiss)
  }

  // MARK: - Edge Case 테스트

  /// Given: 빈 이미지 배열을 가진 프로필 응답이 있을 때
  /// When: loadProfile 액션을 실행하면
  /// Then: profileImageURLs가 비어있다
  func testLoadProfileEmptyImages() async {
    let response = Self.makeProfileResponse(
      profileImages: []
    )
    self.mockRepository.fetchProfileResponse = response
    let viewModel = self.makeViewModel()

    await viewModel.trigger(.loadProfile)

    XCTAssertTrue(viewModel.state.profileImageURLs.isEmpty)
    XCTAssertEqual(viewModel.state.currentImageIndex, 0)
  }

  /// Given: 빈 게임 장르 배열을 가진 프로필 응답이 있을 때
  /// When: loadProfile 액션을 실행하면
  /// Then: gameGenreChips와 gameGenreSelections가 비어있다
  func testLoadProfileEmptyGameGenre() async {
    let response = Self.makeProfileResponse(
      gameGenre: []
    )
    self.mockRepository.fetchProfileResponse = response
    let viewModel = self.makeViewModel()

    await viewModel.trigger(.loadProfile)

    XCTAssertTrue(viewModel.state.gameGenreChips.isEmpty)
    XCTAssertTrue(viewModel.state.gameGenreSelections.isEmpty)
  }

  /// Given: loadProfile 에러 발생 후
  /// When: 다시 loadProfile을 실행하여 성공하면
  /// Then: errorMessage가 nil로 초기화된다
  func testLoadProfileRetryAfterError() async {
    self.profileError = MockNetworkError.networkError
    let viewModel = self.makeViewModel()

    await viewModel.trigger(.loadProfile)
    XCTAssertNotNil(viewModel.state.errorMessage)

    self.profileError = nil
    self.mockRepository.error = nil
    let response = Self.makeProfileResponse()
    self.mockRepository.fetchProfileResponse = response

    await viewModel.trigger(.loadProfile)

    XCTAssertNil(viewModel.state.errorMessage)
    XCTAssertEqual(viewModel.state.nickname, "테스터")
    XCTAssertFalse(viewModel.state.isLoading)
  }
}


// MARK: - Helper

extension UserProfileViewModelTests {

  private func makeViewModel(
    userID: String = "testUser",
    entryType: UserProfileEntryType = .chatList
  ) -> UserProfileViewModel {
    return UserProfileViewModel(
      userID: userID,
      entryType: entryType
    )
  }

  private static func makeProfileResponse(
    userID: String = "testUser",
    nickname: String = "테스터",
    profileImages: [String] = ["https://example.com/image.jpg"],
    birthday: String = "2000-01-01",
    height: String = "175cm",
    job: String = "개발자",
    gameGenre: [String] = ["RPG", "FPS"],
    introduce: String = "안녕하세요",
    mbti: String = "INTJ"
  ) -> UserProfileResponse {
    return UserProfileResponse(
      userID: userID,
      nickname: nickname,
      profileImages: profileImages,
      birthday: birthday,
      height: height,
      job: job,
      gameGenre: gameGenre,
      introduce: introduce,
      mbti: mbti
    )
  }
}
