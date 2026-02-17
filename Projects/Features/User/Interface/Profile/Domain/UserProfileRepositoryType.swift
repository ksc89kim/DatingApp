//
//  UserProfileRepositoryType.swift
//  UserInterface
//
//  Created by kim sunchul on 2/13/26.
//

import Foundation
import DI

public protocol UserProfileRepositoryType: AnyObject, Injectable {

  // MARK: - Method

  func fetchProfile(userID: String) async throws -> UserProfileResponse

  func like(userID: String) async throws

  func skip(userID: String) async throws

  func report(userID: String) async throws

  func block(userID: String) async throws
}
