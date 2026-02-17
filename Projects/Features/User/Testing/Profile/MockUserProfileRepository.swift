//
//  MockUserProfileRepository.swift
//  UserTesting
//
//  Created by kim sunchul on 2/13/26.
//

import Foundation
import UserInterface

final class MockUserProfileRepository: UserProfileRepositoryType {

  // MARK: - Property

  var error: Error?

  var fetchProfileResponse: UserProfileResponse?

  var likedUserIDs: [String] = []

  var skippedUserIDs: [String] = []

  var fetchProfileCallCount: Int = 0

  var likeCallCount: Int = 0

  var skipCallCount: Int = 0

  var lastFetchedUserID: String?

  var lastLikedUserID: String?

  var lastSkippedUserID: String?

  var reportedUserIDs: [String] = []

  var reportCallCount: Int = 0

  var lastReportedUserID: String?

  var blockedUserIDs: [String] = []

  var blockCallCount: Int = 0

  var lastBlockedUserID: String?

  // MARK: - Method

  func fetchProfile(userID: String) async throws -> UserProfileResponse {
    self.fetchProfileCallCount += 1
    self.lastFetchedUserID = userID
    if let error = self.error {
      throw error
    }
    guard let response = self.fetchProfileResponse else {
      throw MockNetworkError.networkError
    }
    return response
  }

  func like(userID: String) async throws {
    self.likeCallCount += 1
    self.lastLikedUserID = userID
    if let error = self.error {
      throw error
    }
    self.likedUserIDs.append(userID)
  }

  func skip(userID: String) async throws {
    self.skipCallCount += 1
    self.lastSkippedUserID = userID
    if let error = self.error {
      throw error
    }
    self.skippedUserIDs.append(userID)
  }

  func report(userID: String) async throws {
    self.reportCallCount += 1
    self.lastReportedUserID = userID
    if let error = self.error {
      throw error
    }
    self.reportedUserIDs.append(userID)
  }

  func block(userID: String) async throws {
    self.blockCallCount += 1
    self.lastBlockedUserID = userID
    if let error = self.error {
      throw error
    }
    self.blockedUserIDs.append(userID)
  }
}
