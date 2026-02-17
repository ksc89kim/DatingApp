import XCTest
@testable import Core

final class NetworkingTests: XCTestCase {

  // MARK: - Property

  private var networking: Networking<MockNetorkAPI>!

  // MARK: - Tests

  override func setUp() {
    super.setUp()

    self.networking = .init(stub: .immediatelyStub)
  }

  func testRequestForBasic() async throws {
    let result = try await self.networking.request(
      MockNetworkResponse.self,
      target: .test
    )
    XCTAssertEqual(result.code, 201)
  }

  func testRequestForAsync() async throws {
    let result = try await self.networking.request(
      MockNetworkResponse.self,
      target: .test
    )
    XCTAssertEqual(result.code, 201)
    XCTAssertEqual(result.message, "테스트")
    XCTAssertTrue(result.data.isNeedUpdate)
  }

  func testParseErrorForAsync() async {
    do {
      _ = try await self.networking.request(
        MockNetworkResponse.self,
        target: .parseError
      )
      XCTFail()
    } catch {
    }
  }

  func testEmptyResponseForAsync() async throws {
    let result = try await self.networking.request(
      EmptyResponse.self,
      target: .empty
    )

    XCTAssertEqual(result.code, 201)
    XCTAssertNil(result.message)
  }
}
