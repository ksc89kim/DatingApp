//
//  MyPageRepositoryType.swift
//  MyPageInterface
//
//  Created by kim sunchul on 2/19/26.
//

import Foundation
import DI
import UserInterface

public protocol MyPageRepositoryType: AnyObject, Injectable {

  // MARK: - Method

  func fetchMyProfile() async throws -> UserProfileResponse

  func updateMyProfile(_ request: MyPageUpdateRequest) async throws -> UserProfileResponse
}
