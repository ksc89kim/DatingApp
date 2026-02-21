//
//  MyPageSettingRepositoryType.swift
//  MyPageInterface
//
//  Created by kim sunchul on 2/21/26.
//

import Foundation
import DI

public protocol MyPageSettingRepositoryType: AnyObject, Injectable {

  // MARK: - Method

  func logout() async throws

  func deleteAccount() async throws
}
