import XCTest
@testable import Core

final class NetworkingTests: XCTestCase {

  // MARK: - Tests

  func testRequestForCompletion() {
    let networking: Networking<MockNetorkAPI> = .init(
      stubClosure: Networking<MockNetorkAPI>.immediatelyStub
    )
    let expectation = XCTestExpectation(description: "Request Completion Expectation")

    _ = networking.request(.testAPI) { result in
      if case .failure = result {
        XCTFail()
      }
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 5.0)
  }

  func testRequestForAsync() async {
    let networking: Networking<MockNetorkAPI> = .init(
      stubClosure: Networking<MockNetorkAPI>.immediatelyStub
    )
    let result = await networking.request(.testAPI)
    if case .failure = result {
      XCTFail()
    }
  }
}
