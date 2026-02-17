import XCTest
@testable import DI
@testable import Core
@testable import MatchingInterface
@testable import Matching
@testable import MatchingTesting
@testable import AppStateInterface

final class MatchingCardViewModelTests: XCTestCase {

  // MARK: - Property

  private var repository: MockMatchingRepository!

  // MARK: - Method

  override func setUp() {
    super.setUp()

    self.repository = .init()

    AppStateDIRegister.register()

    DIContainer.register {
      InjectItem(MatchingRepositoryTypeKey.self) { self.repository }
      InjectItem(MatchingCardViewModelKey.self) {
        return MatchingCardViewModel()
      }
    }
  }

  override func tearDown() {
    super.tearDown()
    self.repository = nil
  }
}
