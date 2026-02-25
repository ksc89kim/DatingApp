//
//  MyPageRepositoryType.swift
//  MyPageInterface
//
//  Created by kim sunchul on 2/19/26.
//

import Foundation
import DI

public protocol MyPageRepositoryType: AnyObject, Injectable {

  // MARK: - Method

  func fetchMyProfile() async throws -> MyPageProfile

  func updateMyProfile(_ request: MyPageUpdateRequest) async throws -> MyPageProfile
}
