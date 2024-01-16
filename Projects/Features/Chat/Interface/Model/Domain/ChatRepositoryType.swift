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

  func chatList(request: ChatListRequest) async throws -> ChatList

  func chosenList(request: ChatChosenListRequest) async throws -> ChatChosenList

  func deleteMessageRoom(roomIdx: String) async throws
  
  func chatRoomMeta(roomIdx: String) async throws -> ChatRoomMeta
  
  func chatMessagese(request: ChatMessagesRequest) async throws -> ChatMessages
}
