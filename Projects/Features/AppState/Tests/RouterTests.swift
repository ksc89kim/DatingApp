import XCTest
@testable import AppStateInterface
@testable import AppStateTesting

final class RouterTests: XCTestCase {

  /// Main > MainRoutePath 추가하기
  func testAppendForMainRoutePath() {
    var router = MockRouter()

    router.append(value: MainRoutePath.launch, for: MockRouteKey.main)
    router.append(value: MainRoutePath.launch, for: MockRouteKey.main)

    XCTAssertEqual(router.main.count, 2)
    XCTAssertTrue(router.mock.isEmpty)
  }

  /// Main > MainRoutePath 제거하기
  func testPathRemoveForMainRoutePath() {
    var router = MockRouter()
    router.main = [.launch, .launch]

    router.remove(value: MainRoutePath.launch, for: MockRouteKey.main)

    XCTAssertTrue(router.main.isEmpty)
    XCTAssertTrue(router.mock.isEmpty)
  }

  /// Mock > MockRoutePath 추가하기
  func testAppendForMockRoutePath() {
    var router = MockRouter()

    router.append(value: MockRoutePath.launch, for: MockRouteKey.mock)
    router.append(value: MockRoutePath.main, for: MockRouteKey.mock)
    router.append(value: MockRoutePath.onboarding, for: MockRouteKey.mock)
    router.append(value: MockRoutePath.signIn, for: MockRouteKey.mock)
    router.append(value: MockRoutePath.singUp, for: MockRouteKey.mock)
    router.append(value: MockRoutePath.signIn, for: MockRouteKey.mock)

    XCTAssertTrue(router.main.isEmpty)
    XCTAssertEqual(router.mock.count, 6)
    XCTAssertEqual(router.mock[0], .launch)
    XCTAssertEqual(router.mock[1], .main)
    XCTAssertEqual(router.mock[2], .onboarding)
    XCTAssertEqual(router.mock[3], .signIn)
    XCTAssertEqual(router.mock[4], .singUp)
    XCTAssertEqual(router.mock[5], .signIn)
  }

  /// Mock > MockRoutePath 삭제하기
  func testRemoveForMockRoutePath() {
    var router = MockRouter()
    router.mock = [.launch, .main, .onboarding, .signIn, .singUp]

    router.remove(value: MockRoutePath.signIn, for: MockRouteKey.mock)
    router.remove(value: MockRoutePath.main, for: MockRouteKey.mock)

    XCTAssertTrue(router.main.isEmpty)
    XCTAssertEqual(router.mock.count, 3)
    XCTAssertEqual(router.mock[0], .launch)
    XCTAssertEqual(router.mock[1], .onboarding)
    XCTAssertEqual(router.mock[2], .singUp)
  }
}
