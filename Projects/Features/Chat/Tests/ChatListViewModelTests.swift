import XCTest
@testable import DI
@testable import Core
@testable import ChatInterface
@testable import Chat
@testable import ChatTesting
@testable import AppStateInterface

final class ChatListViewModelTests: XCTestCase {

  // MARK: - Property

  private var repository: MockChatRepository!

  // MARK: - Method

  override func setUp() {
    super.setUp()

    self.repository = .init()
    AppStateDIRegister.register()

    DIContainer.register { [weak self] in
      InjectItem(ChatRepositoryKey.self) {
        return self!.repository
      }
    }
  }

  /// 메시지 리스트 로드
  func testMessageListLoad() async {
    let pagination = Pagination()
    let viewModel: ChatListViewModel = .init(
      listPagination: pagination,
      chosenPagination: Pagination()
    )

    await viewModel.trigger(.loadMessageList)

    XCTAssertEqual(viewModel.state.messages.count, pagination.state.limit)
  }

  /// 메시지 리스트 더보기
  func testMessageListLoadMore() async {
    let pagination = Pagination()
    let viewModel: ChatListViewModel = .init(
      listPagination: pagination,
      chosenPagination: Pagination()
    )
    viewModel.state.messages = [
      .dummy()
    ]

    await viewModel.trigger(
      .loadMessageListMore(index: pagination.state.itemsFromEndThreshold)
    )

    XCTAssertEqual(viewModel.state.messages.count, pagination.state.limit + 1)
    let page = pagination.state.page
    XCTAssertEqual(page, 1)
  }

  /// 메시지 리스트의 마지막 페이지 이후 호출 테스트
  func testMessageListPageOver() async {
    let pagination = Pagination()
    let threshold = pagination.state.itemsFromEndThreshold
    self.repository.isFianl = true
    let viewModel: ChatListViewModel = .init(
      listPagination: pagination,
      chosenPagination: Pagination()
    )

    await viewModel.trigger(
      .loadMessageListMore(index: threshold)
    )

    let loadedCount = pagination.state.itemsLoadedCount

    await viewModel.trigger(
      .loadMessageListMore(index: loadedCount + threshold)
    )

    XCTAssertEqual(viewModel.state.messages.count, pagination.state.limit)
  }

  /// 리스트 제목
  func testListTitle() async {
    let viewModel: ChatListViewModel = .init(
      listPagination: Pagination(),
      chosenPagination: Pagination()
    )

    await viewModel.trigger(.loadMessageList)

    XCTAssertEqual(viewModel.state.listTitle, "100개의 대화방")
  }

  /// 메시지방 삭제하기
  func testDeleteMessageRoom() async {
    let pagination = Pagination()
    let viewModel: ChatListViewModel = .init(
      listPagination: pagination,
      chosenPagination: Pagination()
    )

    await viewModel.trigger(.loadMessageList)
    await viewModel.trigger(.deleteMessageRoom(roomIdx: "room.1"))

    XCTAssertEqual(viewModel.state.messages.count, pagination.state.limit - 1)
  }

  /// 나를 선택한 친구 리스트 로드
  func testChosenListLoad() async {
    let pagination = Pagination()
    let viewModel: ChatListViewModel = .init(
      listPagination: Pagination(),
      chosenPagination: pagination
    )

    await viewModel.trigger(.loadChosenList)

    XCTAssertEqual(viewModel.state.chosenUsers.count, pagination.state.limit)
  }

  /// 나를 선택한 친구 리스트 더보기 로드
  func testChosenListLoadMore() async {
    let pagination = Pagination()
    let viewModel: ChatListViewModel = .init(
      listPagination: Pagination(),
      chosenPagination: pagination
    )
    viewModel.state.chosenUsers = [
      .dummy()
    ]

    await viewModel.trigger(
      .loadChosenListMore(index: pagination.state.itemsFromEndThreshold)
    )

    XCTAssertEqual(viewModel.state.chosenUsers.count, pagination.state.limit + 1)
    let page = pagination.state.page
    XCTAssertEqual(page, 1)
  }

  /// 나를 선택한 친구 리스트 페이지 이후 호출 테스트
  func testChosenListPageOver() async {
    let pagination = Pagination()
    let threshold = pagination.state.itemsFromEndThreshold
    self.repository.isFianl = true
    let viewModel: ChatListViewModel = .init(
      listPagination: Pagination(),
      chosenPagination: pagination
    )

    await viewModel.trigger(
      .loadChosenListMore(index: threshold)
    )

    let loadedCount = pagination.state.itemsLoadedCount

    await viewModel.trigger(
      .loadChosenListMore(index: loadedCount + threshold)
    )

    XCTAssertEqual(viewModel.state.chosenUsers.count, pagination.state.limit)
  }

  /// 메시지 리스트 에러 알럿 테스트
  func testErrorAlertFromMessageList() async {
    self.repository.error = MockChatRepository.NetworkError.default
    let viewModel: ChatListViewModel = .init(
      listPagination: Pagination(),
      chosenPagination: Pagination()
    )

    await viewModel.trigger(.loadMessageList)

    XCTAssertTrue(viewModel.state.isPresentAlert)
  }

  /// 나를 선택한 친구 리스트 에러 알럿 테스트
  func testErrorAlertFromChosenList() async {
    self.repository.error = MockChatRepository.NetworkError.default
    let viewModel: ChatListViewModel = .init(
      listPagination: Pagination(),
      chosenPagination: Pagination()
    )
    
    await viewModel.trigger(.loadChosenList)

    XCTAssertTrue(viewModel.state.isPresentAlert)
  }

  /// 채팅방이 없는 경우
  func testCheckEmptyView() async {
    self.repository.isEmpty = true
    let viewModel: ChatListViewModel = .init(
      listPagination: Pagination(),
      chosenPagination: Pagination()
    )

    await viewModel.trigger(.load)

    XCTAssertTrue(viewModel.state.isEmpty)
  }

  func testPresentChatRoom() {
    let viewModel: ChatListViewModel = .init(
      listPagination: Pagination(),
      chosenPagination: Pagination()
    )
    let roomIdx = "test1"

    viewModel.trigger(.presentRoom(roomIdx: roomIdx))

    let firstPath = AppState.instance.chatRouter.paths.first
    XCTAssertEqual(firstPath, .chatRoom(idx: roomIdx))
  }
}
