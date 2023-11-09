import XCTest
@testable import AppStateInterface
@testable import AppStateTesting

final class RouterTests: XCTestCase {

  /// 경로 추가하기
  func testAppendRoutePath() {
    var router = MockRouter()

    router.append(path: MockRoutePath.launch, for: MockRouteKey.mock)
    router.append(path: MockRoutePath.main, for: MockRouteKey.mock)
    router.append(path: MockRoutePath.onboarding, for: MockRouteKey.mock)
    router.append(path: MockRoutePath.signIn, for: MockRouteKey.mock)
    router.append(path: MockRoutePath.singUp, for: MockRouteKey.mock)
    router.append(path: MockRoutePath.signIn, for: MockRouteKey.mock)

    XCTAssertTrue(router.main.isEmpty)
    XCTAssertEqual(router.mock.count, 6)
    XCTAssertEqual(router.mock[0], .launch)
    XCTAssertEqual(router.mock[1], .main)
    XCTAssertEqual(router.mock[2], .onboarding)
    XCTAssertEqual(router.mock[3], .signIn)
    XCTAssertEqual(router.mock[4], .singUp)
    XCTAssertEqual(router.mock[5], .signIn)
  }

  /// 경로 삭제하기
  func testRemoveRoutePath() {
    var router = MockRouter()
    router.mock = [.launch, .main, .onboarding, .signIn, .singUp]

    router.remove(path: MockRoutePath.signIn, for: MockRouteKey.mock)
    router.remove(path: MockRoutePath.main, for: MockRouteKey.mock)

    XCTAssertTrue(router.main.isEmpty)
    XCTAssertEqual(router.mock.count, 3)
    XCTAssertEqual(router.mock[0], .launch)
    XCTAssertEqual(router.mock[1], .onboarding)
    XCTAssertEqual(router.mock[2], .singUp)
  }

  /// 경로 설정 하기
  func testSetRoutePath() {
    var router = MockRouter()
    router.mock = [.launch, .main, .onboarding, .signIn, .singUp]

    router.set(type: MockRoutePath.self, paths: [.signIn], for: MockRouteKey.mock)

    XCTAssertTrue(router.main.isEmpty)
    XCTAssertEqual(router.mock.count, 1)
    XCTAssertEqual(router.mock[0], .signIn)
  }
}
