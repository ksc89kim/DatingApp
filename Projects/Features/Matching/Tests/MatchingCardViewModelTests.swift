import XCTest
@testable import DI
@testable import Core
@testable import MatchingInterface
@testable import Matching
@testable import MatchingTesting
@testable import AppStateInterface

final class MatchingCardViewModelTests: XCTestCase {

  // MARK: - Property

  private var repository: MockMatchingRepository!

  // MARK: - Method

  override func setUp() {
    super.setUp()

    self.repository = .init()

    AppStateDIRegister.register()
    AppState.instance.matchingRouter.removeAll()
    AppState.instance.chatRouter.removeAll()

    DIContainer.register {
      InjectItem(MatchingRepositoryTypeKey.self) { self.repository }
      InjectItem(MatchingCardViewModelKey.self) {
        return MatchingCardViewModel()
      }
    }
  }

  override func tearDown() {
    super.tearDown()
    self.repository = nil
  }

  // MARK: - 초기 상태 테스트

  /// Given: ViewModel을 생성할 때
  /// When: 아무 액션도 실행하지 않으면
  /// Then: 초기 상태값이 올바르다
  func testInitialState() {
    let viewModel = MatchingCardViewModel()

    XCTAssertTrue(viewModel.state.cards.isEmpty)
    XCTAssertEqual(viewModel.state.currentIndex, 0)
    XCTAssertEqual(viewModel.state.page, 1)
    XCTAssertTrue(viewModel.state.hasMore)
    XCTAssertFalse(viewModel.state.isLoading)
    XCTAssertFalse(viewModel.state.isFetchingMore)
    XCTAssertFalse(viewModel.state.isEmpty)
    XCTAssertNil(viewModel.state.matchedUser)
    XCTAssertFalse(viewModel.state.isShowingMatchOverlay)
    XCTAssertFalse(viewModel.state.isPresentAlert)
  }

  // MARK: - load 액션 테스트

  /// Given: 카드 목록 응답이 있을 때
  /// When: load 액션을 실행하면
  /// Then: 카드 목록이 State에 반영되고 isLoading이 false가 된다
  func testLoadSuccess() async {
    let cards = Self.makeCards(count: 5)
    self.repository.fetchRecommendationsResult = .init(
      recommendations: cards,
      hasMore: true
    )
    let viewModel = MatchingCardViewModel()

    await viewModel.trigger(.load)

    XCTAssertEqual(viewModel.state.cards.count, 5)
    XCTAssertEqual(viewModel.state.currentIndex, 0)
    XCTAssertEqual(viewModel.state.page, 1)
    XCTAssertTrue(viewModel.state.hasMore)
    XCTAssertFalse(viewModel.state.isLoading)
    XCTAssertFalse(viewModel.state.isEmpty)
  }

  /// Given: 빈 카드 목록 응답이 있을 때
  /// When: load 액션을 실행하면
  /// Then: isEmpty가 true가 된다
  func testLoadEmptyResult() async {
    self.repository.fetchRecommendationsResult = .init(
      recommendations: [],
      hasMore: false
    )
    let viewModel = MatchingCardViewModel()

    await viewModel.trigger(.load)

    XCTAssertTrue(viewModel.state.cards.isEmpty)
    XCTAssertTrue(viewModel.state.isEmpty)
    XCTAssertFalse(viewModel.state.isLoading)
    XCTAssertFalse(viewModel.state.hasMore)
  }

  /// Given: 네트워크 에러가 발생할 때
  /// When: load 액션을 실행하면
  /// Then: 에러 알럿이 표시되고 isLoading이 false가 된다
  func testLoadFailure() async {
    self.repository.fetchRecommendationsError = MockMatchingError.networkError
    let viewModel = MatchingCardViewModel()

    await viewModel.trigger(.load)

    XCTAssertTrue(viewModel.state.isPresentAlert)
    XCTAssertFalse(viewModel.state.isLoading)
    XCTAssertTrue(viewModel.state.cards.isEmpty)
  }

  // MARK: - like 액션 테스트

  /// Given: 카드 목록이 로드된 상태에서, 매칭이 되지 않을 때
  /// When: like 액션을 실행하면
  /// Then: 현재 카드가 제거되고 matchOverlay가 표시되지 않는다
  func testLikeSuccessWithoutMatch() async {
    let cards = Self.makeCards(count: 5)
    self.repository.fetchRecommendationsResult = .init(
      recommendations: cards,
      hasMore: false
    )
    self.repository.likeResult = .init(isMatched: false)
    let viewModel = MatchingCardViewModel()
    await viewModel.trigger(.load)

    await viewModel.trigger(.like)

    XCTAssertEqual(viewModel.state.cards.count, 4)
    XCTAssertFalse(viewModel.state.isShowingMatchOverlay)
    XCTAssertNil(viewModel.state.matchedUser)
    XCTAssertFalse(viewModel.state.isPresentAlert)
  }

  /// Given: 카드 목록이 로드된 상태에서, 매칭이 성립될 때
  /// When: like 액션을 실행하면
  /// Then: 카드가 제거되고 matchOverlay가 표시되며 matchedUser가 설정된다
  func testLikeSuccessWithMatch() async {
    let cards = Self.makeCards(count: 5)
    self.repository.fetchRecommendationsResult = .init(
      recommendations: cards,
      hasMore: false
    )
    self.repository.likeResult = .init(isMatched: true, matchedUserID: "user-1")
    let viewModel = MatchingCardViewModel()
    await viewModel.trigger(.load)

    let firstCard = viewModel.state.cards.first
    await viewModel.trigger(.like)

    XCTAssertEqual(viewModel.state.cards.count, 4)
    XCTAssertTrue(viewModel.state.isShowingMatchOverlay)
    XCTAssertNotNil(viewModel.state.matchedUser)
    XCTAssertEqual(viewModel.state.matchedUser?.userID, firstCard?.userID)
  }

  /// Given: 네트워크 에러가 발생할 때
  /// When: like 액션을 실행하면
  /// Then: 에러 알럿이 표시되고 카드 목록이 변경되지 않는다
  func testLikeFailure() async {
    let cards = Self.makeCards(count: 5)
    self.repository.fetchRecommendationsResult = .init(
      recommendations: cards,
      hasMore: false
    )
    self.repository.likeError = MockMatchingError.networkError
    let viewModel = MatchingCardViewModel()
    await viewModel.trigger(.load)

    await viewModel.trigger(.like)

    XCTAssertEqual(viewModel.state.cards.count, 5)
    XCTAssertTrue(viewModel.state.isPresentAlert)
    XCTAssertFalse(viewModel.state.isShowingMatchOverlay)
  }

  // MARK: - skip 액션 테스트

  /// Given: 카드 목록이 로드된 상태에서
  /// When: skip 액션을 실행하면
  /// Then: 현재 카드가 제거된다
  func testSkipSuccess() async {
    let cards = Self.makeCards(count: 5)
    self.repository.fetchRecommendationsResult = .init(
      recommendations: cards,
      hasMore: false
    )
    let viewModel = MatchingCardViewModel()
    await viewModel.trigger(.load)

    await viewModel.trigger(.skip)

    XCTAssertEqual(viewModel.state.cards.count, 4)
    XCTAssertFalse(viewModel.state.isPresentAlert)
  }

  /// Given: 네트워크 에러가 발생할 때
  /// When: skip 액션을 실행하면
  /// Then: 에러 알럿이 표시되고 카드 목록이 변경되지 않는다
  func testSkipFailure() async {
    let cards = Self.makeCards(count: 5)
    self.repository.fetchRecommendationsResult = .init(
      recommendations: cards,
      hasMore: false
    )
    self.repository.skipError = MockMatchingError.networkError
    let viewModel = MatchingCardViewModel()
    await viewModel.trigger(.load)

    await viewModel.trigger(.skip)

    XCTAssertEqual(viewModel.state.cards.count, 5)
    XCTAssertTrue(viewModel.state.isPresentAlert)
  }

  // MARK: - swipe 액션 테스트

  /// Given: 카드 목록이 로드된 상태에서
  /// When: 오른쪽으로 스와이프하면
  /// Then: like가 호출되어 카드가 제거된다
  func testSwipeRightCallsLike() async {
    let cards = Self.makeCards(count: 5)
    self.repository.fetchRecommendationsResult = .init(
      recommendations: cards,
      hasMore: false
    )
    self.repository.likeResult = .init(isMatched: false)
    let viewModel = MatchingCardViewModel()
    await viewModel.trigger(.load)

    await viewModel.trigger(.swipe(direction: .right))

    XCTAssertEqual(viewModel.state.cards.count, 4)
    XCTAssertFalse(viewModel.state.isPresentAlert)
  }

  /// Given: 카드 목록이 로드된 상태에서
  /// When: 왼쪽으로 스와이프하면
  /// Then: skip이 호출되어 카드가 제거된다
  func testSwipeLeftCallsSkip() async {
    let cards = Self.makeCards(count: 5)
    self.repository.fetchRecommendationsResult = .init(
      recommendations: cards,
      hasMore: false
    )
    let viewModel = MatchingCardViewModel()
    await viewModel.trigger(.load)

    await viewModel.trigger(.swipe(direction: .left))

    XCTAssertEqual(viewModel.state.cards.count, 4)
    XCTAssertFalse(viewModel.state.isPresentAlert)
  }

  // MARK: - prefetch 테스트

  /// Given: 카드 수가 prefetchThreshold(3) 이하이고 hasMore가 true일 때
  /// When: like 또는 skip으로 카드를 제거하면
  /// Then: 다음 페이지가 자동으로 로드된다
  func testPrefetchWhenCardsAtThreshold() async {
    let initialCards = Self.makeCards(count: 4, idPrefix: "initial")
    let moreCards = Self.makeCards(count: 5, idPrefix: "more")
    self.repository.fetchRecommendationsResult = .init(
      recommendations: initialCards,
      hasMore: true
    )
    self.repository.likeResult = .init(isMatched: false)
    let viewModel = MatchingCardViewModel()
    await viewModel.trigger(.load)

    self.repository.fetchRecommendationsResult = .init(
      recommendations: moreCards,
      hasMore: false
    )

    await viewModel.trigger(.like)

    XCTAssertGreaterThan(viewModel.state.cards.count, 3)
  }

  /// Given: hasMore가 false일 때
  /// When: 카드 수가 threshold 이하가 되어도
  /// Then: 추가 로드를 시도하지 않는다
  func testNoPrefetchWhenNoMorePages() async {
    let cards = Self.makeCards(count: 4)
    self.repository.fetchRecommendationsResult = .init(
      recommendations: cards,
      hasMore: false
    )
    self.repository.likeResult = .init(isMatched: false)
    let viewModel = MatchingCardViewModel()
    await viewModel.trigger(.load)

    await viewModel.trigger(.like)

    XCTAssertEqual(viewModel.state.cards.count, 3)
    XCTAssertEqual(viewModel.state.page, 1)
  }

  // MARK: - dismissMatchOverlay 테스트

  /// Given: matchOverlay가 표시된 상태에서
  /// When: dismissMatchOverlay 액션을 실행하면
  /// Then: isShowingMatchOverlay가 false가 되고 matchedUser가 nil이 된다
  func testDismissMatchOverlay() async {
    let cards = Self.makeCards(count: 5)
    self.repository.fetchRecommendationsResult = .init(
      recommendations: cards,
      hasMore: false
    )
    self.repository.likeResult = .init(isMatched: true, matchedUserID: "user-1")
    let viewModel = MatchingCardViewModel()
    await viewModel.trigger(.load)
    await viewModel.trigger(.like)
    XCTAssertTrue(viewModel.state.isShowingMatchOverlay)

    await viewModel.trigger(.dismissMatchOverlay)

    XCTAssertFalse(viewModel.state.isShowingMatchOverlay)
    XCTAssertNil(viewModel.state.matchedUser)
  }

  // MARK: - sendMessage 테스트

  /// Given: matchOverlay가 표시된 상태에서
  /// When: sendMessage 액션을 실행하면
  /// Then: isShowingMatchOverlay가 false가 되고 chatRouter에 경로가 추가된다
  func testSendMessageHidesOverlayAndNavigatesToChat() async {
    let cards = Self.makeCards(count: 5)
    self.repository.fetchRecommendationsResult = .init(
      recommendations: cards,
      hasMore: false
    )
    self.repository.likeResult = .init(isMatched: true, matchedUserID: "user-1")
    let viewModel = MatchingCardViewModel()
    await viewModel.trigger(.load)
    let matchedCardUserID = viewModel.state.cards.first?.userID ?? ""
    await viewModel.trigger(.like)
    XCTAssertTrue(viewModel.state.isShowingMatchOverlay)

    await viewModel.trigger(.sendMessage)

    XCTAssertFalse(viewModel.state.isShowingMatchOverlay)
    XCTAssertNil(viewModel.state.matchedUser)
    let chatPath = AppState.instance.chatRouter.paths.first
    XCTAssertEqual(chatPath, .chatRoom(idx: matchedCardUserID))
  }

  /// Given: matchedUser가 nil인 상태에서
  /// When: sendMessage 액션을 실행하면
  /// Then: chatRouter에 경로가 추가되지 않는다
  func testSendMessageWithoutMatchedUserDoesNothing() async {
    let viewModel = MatchingCardViewModel()

    await viewModel.trigger(.sendMessage)

    XCTAssertTrue(AppState.instance.chatRouter.isEmpty)
    XCTAssertFalse(viewModel.state.isShowingMatchOverlay)
  }

  // MARK: - showProfile 테스트

  /// Given: 프로필 화면으로 이동하려 할 때
  /// When: showProfile 액션을 실행하면
  /// Then: matchingRouter에 userProfile 경로가 추가된다
  func testShowProfileNavigatesToUserProfile() async {
    let viewModel = MatchingCardViewModel()
    let userID = "test-user-123"

    await viewModel.trigger(.showProfile(userID: userID))

    let path = AppState.instance.matchingRouter.paths.first
    XCTAssertEqual(path, .userProfile(userID: userID))
  }

  // MARK: - 카드 소진 테스트

  /// Given: 카드가 1장 남은 상태에서
  /// When: like 또는 skip으로 마지막 카드를 제거하면
  /// Then: isEmpty가 true가 된다
  func testEmptyStateAfterLastCard() async {
    let cards = Self.makeCards(count: 1)
    self.repository.fetchRecommendationsResult = .init(
      recommendations: cards,
      hasMore: false
    )
    self.repository.likeResult = .init(isMatched: false)
    let viewModel = MatchingCardViewModel()
    await viewModel.trigger(.load)

    await viewModel.trigger(.like)

    XCTAssertTrue(viewModel.state.cards.isEmpty)
    XCTAssertTrue(viewModel.state.isEmpty)
  }

  /// Given: 카드가 없는 상태에서
  /// When: like 액션을 실행하면
  /// Then: 아무것도 변경되지 않는다 (guard 조건으로 early return)
  func testLikeWithNoCards() async {
    let viewModel = MatchingCardViewModel()

    await viewModel.trigger(.like)

    XCTAssertTrue(viewModel.state.cards.isEmpty)
    XCTAssertFalse(viewModel.state.isPresentAlert)
  }

  /// Given: 카드가 없는 상태에서
  /// When: skip 액션을 실행하면
  /// Then: 아무것도 변경되지 않는다 (guard 조건으로 early return)
  func testSkipWithNoCards() async {
    let viewModel = MatchingCardViewModel()

    await viewModel.trigger(.skip)

    XCTAssertTrue(viewModel.state.cards.isEmpty)
    XCTAssertFalse(viewModel.state.isPresentAlert)
  }

  // MARK: - 에러 알럿 메시지 검증

  /// Given: like 네트워크 에러가 발생할 때
  /// When: like 액션을 실행하면
  /// Then: 에러 메시지가 alert에 반영된다
  func testLikeErrorAlertMessage() async {
    let cards = Self.makeCards(count: 5)
    self.repository.fetchRecommendationsResult = .init(
      recommendations: cards,
      hasMore: false
    )
    self.repository.likeError = MockMatchingError.networkError
    let viewModel = MatchingCardViewModel()
    await viewModel.trigger(.load)

    await viewModel.trigger(.like)

    XCTAssertTrue(viewModel.state.isPresentAlert)
    XCTAssertEqual(
      viewModel.state.alert.message,
      MockMatchingError.networkError.localizedDescription
    )
  }

  /// Given: skip 네트워크 에러가 발생할 때
  /// When: skip 액션을 실행하면
  /// Then: 에러 메시지가 alert에 반영된다
  func testSkipErrorAlertMessage() async {
    let cards = Self.makeCards(count: 5)
    self.repository.fetchRecommendationsResult = .init(
      recommendations: cards,
      hasMore: false
    )
    self.repository.skipError = MockMatchingError.networkError
    let viewModel = MatchingCardViewModel()
    await viewModel.trigger(.load)

    await viewModel.trigger(.skip)

    XCTAssertTrue(viewModel.state.isPresentAlert)
    XCTAssertEqual(
      viewModel.state.alert.message,
      MockMatchingError.networkError.localizedDescription
    )
  }

  /// Given: load 네트워크 에러가 발생할 때
  /// When: load 액션을 실행하면
  /// Then: 에러 메시지가 alert에 반영된다
  func testLoadErrorAlertMessage() async {
    self.repository.fetchRecommendationsError = MockMatchingError.networkError
    let viewModel = MatchingCardViewModel()

    await viewModel.trigger(.load)

    XCTAssertTrue(viewModel.state.isPresentAlert)
    XCTAssertEqual(
      viewModel.state.alert.message,
      MockMatchingError.networkError.localizedDescription
    )
  }
}


// MARK: - Helper

extension MatchingCardViewModelTests {

  private static func makeCards(
    count: Int,
    idPrefix: String = "user"
  ) -> [MatchingCardItem] {
    return (1...count).map { index in
      MatchingCardItem(
        userID: "\(idPrefix)-\(index)",
        nickname: "유저\(index)",
        age: 25 + index,
        profileImages: ["https://example.com/image\(index).jpg"],
        job: "직업\(index)",
        introduce: "소개\(index)"
      )
    }
  }
}


// MARK: - MockMatchingError

enum MockMatchingError: LocalizedError {
  case networkError

  var errorDescription: String? {
    switch self {
    case .networkError: return "네트워크 오류가 발생했습니다."
    }
  }
}
