import XCTest
@testable import Core

final class NetworkingTests: XCTestCase {

  // MARK: - Tests

  func testRequestForCompletion() {
    let networking: Networking<MockNetorkAPI> = .init(
      stubClosure: Networking<MockNetorkAPI>.immediatelyStub
    )
    let expectation = XCTestExpectation(description: "Request Completion Expectation")

    _ = networking.request(.test) { result in
      if case .failure = result {
        XCTFail()
      }
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 5.0)
  }

  func testRequestForAsync() async throws {
    let networking: Networking<MockNetorkAPI> = .init(
      stubClosure: Networking<MockNetorkAPI>.immediatelyStub
    )

    let result = try await networking.request(
      MockNetworkResponse.self,
      target: .test
    )
    XCTAssertEqual(result.code, 201)
    XCTAssertEqual(result.message, "테스트")
    XCTAssertTrue(result.data.isNeedUpdate)
  }

  func testParseErrorForAsync() async {
    let networking: Networking<MockNetorkAPI> = .init(
      stubClosure: Networking<MockNetorkAPI>.immediatelyStub
    )

    do {
      _ = try await networking.request(
        MockNetworkResponse.self,
        target: .parseError
      )
      XCTFail()
    } catch {
    }
  }

  func testEmptyResponseForAsync() async throws {
    let networking: Networking<MockNetorkAPI> = .init(
      stubClosure: Networking<MockNetorkAPI>.immediatelyStub
    )

    let result = try await networking.request(
      EmptyResponse.self,
      target: .empty
    )

    XCTAssertEqual(result.code, 201)
    XCTAssertNil(result.message)
  }
}
