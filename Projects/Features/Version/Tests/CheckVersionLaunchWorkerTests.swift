import XCTest
@testable import VersionInterface
@testable import VersionTesting
@testable import Version
@testable import DI

final class CheckVersionLaunchWorkerTests: XCTestCase {

  // MARK: - Property

  private var worker: CheckVersionLaunchWorker!

  private var isForceUpdate: Bool?

  // MARK: - Tests

  override func setUp() {
    super.setUp()

    self.worker = .init()
    self.isForceUpdate = nil

    DIContainer.register { [weak self] in
      InjectItem(VersionRepositoryTypeKey.self) {
        let repository = MockVersionRepository()
        repository.isForceUpdate = self?.isForceUpdate ?? false
        return repository
      }
    }
  }

  /// Work 기본 테스트
  func testWork() async throws {
    try await self.worker.work()
  }

  /// 강제 업데이트 테스트
  func testForceUpdateFromWork() async {
    self.isForceUpdate = true

    do {
      try await self.worker.work()
      XCTFail()
    } catch {
      if let error = error as? CheckVersionLaunchWorkError,
         case .forceUpdate(let entity) = error {
        XCTAssertEqual(entity.isForceUpdate, true)
        XCTAssertEqual(entity.message, "업데이트가 필요합니다.")
        XCTAssertEqual(entity.linkURL?.absoluteString, "http://itunes.apple.com/kr/app/")
      } else {
        XCTFail()
      }
    }
  }
}
