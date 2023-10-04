import XCTest
@testable import AppStateInterface

final class RouterTests: XCTestCase {

  /// MainRouterPath 추가하기
  func testAppendForMainRouterPath() {
    var router = Router()

    router.append(value: MainRoutePath.launch, for: .main)

    XCTAssertEqual(router.main.count, 1)
  }

  /// MainRouterPath 제거하기
  func testPathRemove() {
    var router = Router()
    router.main = [.launch, .launch]

    router.remove(value: MainRoutePath.launch, for: .main)

    XCTAssertTrue(router.main.isEmpty)
  }
}
