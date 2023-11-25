import XCTest
@testable import AppStateInterface
@testable import AppStateTesting

final class RouterTests: XCTestCase {

  /// 경로 추가하기
  func testAppendRoutePath() {
    var router = MockRouter()

    router.append(path: .launch)
    router.append(path: .main)
    router.append(path: .onboarding)
    router.append(path: .signIn)
    router.append(path: .singUp)
    router.append(path: .signIn)

    XCTAssertEqual(router.count, 6)
    XCTAssertEqual(router.paths[0], .launch)
    XCTAssertEqual(router.paths[1], .main)
    XCTAssertEqual(router.paths[2], .onboarding)
    XCTAssertEqual(router.paths[3], .signIn)
    XCTAssertEqual(router.paths[4], .singUp)
    XCTAssertEqual(router.paths[5], .signIn)
  }

  /// 경로 삭제하기
  func testRemoveRoutePath() {
    var router = MockRouter()
    router.paths = [.launch, .main, .onboarding, .signIn, .singUp]

    router.remove(path: .signIn)
    router.remove(path: .main)

    XCTAssertEqual(router.count, 3)
    XCTAssertEqual(router.paths[0], .launch)
    XCTAssertEqual(router.paths[1], .onboarding)
    XCTAssertEqual(router.paths[2], .singUp)
  }

  /// 경로 설정 하기
  func testSetRoutePath() {
    var router = MockRouter()
    router.paths = [.launch, .main, .onboarding, .signIn, .singUp]

    router.set(paths: [.signIn])

    XCTAssertEqual(router.count, 1)
    XCTAssertEqual(router.paths[0], .signIn)
  }
}
