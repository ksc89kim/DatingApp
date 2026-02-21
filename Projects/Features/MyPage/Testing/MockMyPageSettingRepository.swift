//
//  MockMyPageSettingRepository.swift
//  MyPageTesting
//
//  Created by kim sunchul on 2/21/26.
//

import Foundation
import MyPageInterface

public final class MockMyPageSettingRepository: MyPageSettingRepositoryType {

  // MARK: - Property

  public var logoutError: Error?

  public var deleteAccountError: Error?

  public var logoutCallCount: Int = 0

  public var deleteAccountCallCount: Int = 0

  // MARK: - Init

  public init() {}

  // MARK: - Method

  public func logout() async throws {
    self.logoutCallCount += 1
    if let error = self.logoutError {
      throw error
    }
  }

  public func deleteAccount() async throws {
    self.deleteAccountCallCount += 1
    if let error = self.deleteAccountError {
      throw error
    }
  }
}
