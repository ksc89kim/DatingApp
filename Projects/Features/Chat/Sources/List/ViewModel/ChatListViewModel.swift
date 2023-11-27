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

public final class ChatListViewModel: ViewModelType, Injectable {

  // MARK: - Property

  @Published
  public var state: ChatListState = .init()

  // MARK: - Method

  public func trigger(_ action: ChatListAction) { }
}
