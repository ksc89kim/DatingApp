import XCTest
@testable import DI
@testable import Core
@testable import MatchingInterface
@testable import Home
@testable import HomeTesting
@testable import AppStateInterface

final class HomeViewModelTests: XCTestCase {

  // MARK: - Method

  override func setUp() {
    super.setUp()
    AppStateDIRegister.register()
  }
}
