import XCTest
@testable import VersionInterface
@testable import VersionTesting
@testable import Version
@testable import DI

final class CheckVersionLaunchWorkerTests: XCTestCase {

  // MARK: - Property

  private var worker: CheckVersionLaunchWorker!

  // MARK: - Tests

  override func setUp() {
    super.setUp()

    self.worker = .init()
  }

  /// Work 기본 테스트
  func testWork() async throws {
    DIContainer.register {
      InjectItem(VersionRepositoryTypeKey.self) {
        let repository = MockVersionRepository()
        return repository
      }
    }

    try await self.worker.work()
  }

  /// 강제 업데이트 테스트
  func testForceUpdateFromWork() async {
    DIContainer.register {
      InjectItem(VersionRepositoryTypeKey.self) {
        let repository = MockVersionRepository()
        repository.isForceUpdate = true
        return repository
      }
    }

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
