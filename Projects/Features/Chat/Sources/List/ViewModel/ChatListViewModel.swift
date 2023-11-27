//
//  ChatListViewModel.swift
//  Chat
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import Core
import DI

final class ChatListViewModel: ViewModelType, Injectable {

  // MARK: - Property

  @Published
  var state: ChatListState = .init()

  // MARK: - Method

  func trigger(_ action: ChatListAction) { }
}
