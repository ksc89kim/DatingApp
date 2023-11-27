//
//  ChatRepositoryType.swift
//  ChatInterface
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import DI

public protocol ChatRepositoryType: AnyObject, Injectable {

  // MARK: - Method

  func chatList() async throws -> ChatListEntity

  func chosenList() async throws -> ChatChosenEntity
}
