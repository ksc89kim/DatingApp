import XCTest
@testable import VersionInterface
@testable import VersionTesting
@testable import Version

final class CheckVersionLaunchWorkerTests: XCTestCase {

  // MARK: - Property

  private var worker: CheckVersionLaunchWorker!

  private var mockRepository: MockVersionRepository!

  // MARK: - Tests

  override func setUp() {
    super.setUp()

    self.mockRepository = MockVersionRepository()
    self.worker = .init(repository: self.mockRepository)
  }

  func testWork() async throws {
    try await self.worker.work()
  }

  func testForceUpdateFromWork() async {
    self.mockRepository.isForceUpdate = true

    do {
      try await self.worker.work()
      XCTFail()
    } catch {
      if let error = error as? CheckVersionLaunchWorkError,
         case .forceUpdate(let entity) = error {
        XCTAssertEqual(entity.isForceUpdate, true)
        XCTAssertEqual(entity.message, "업데이트가 필요합니다.")
        XCTAssertEqual(entity.linkURL.absoluteString, "http://itunes.apple.com/kr/app/")
      } else {
        XCTFail()
      }
    }
  }
}
