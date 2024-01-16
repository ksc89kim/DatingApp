//
//  ChatDIRegister.swift
//  Chat
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import DI
import ChatInterface
import Core

public struct ChatDIRegister {

  // MARK: - Method

  public static func register() {
    DIContainer.register {
      InjectItem(ChatHomeViewKey.self) { ChatHomeView() }
      InjectItem(ChatRepositoryKey.self) {
        let repository = ChatRepository(
          networking: .init(stubClosure: Networking<ChatAPI>.immediatelyStub)
        )
        return repository
      }
      InjectItem(ChatListViewModelKey.self) {
        return ChatListViewModel(
          listPagination: Pagination(),
          chosenPagination: Pagination()
        )
      }
      InjectItem(ChatRoomViewModelKey.self) {
        return ChatRoomViewModel(pagination: Pagination())
      }
    }
  }
}
