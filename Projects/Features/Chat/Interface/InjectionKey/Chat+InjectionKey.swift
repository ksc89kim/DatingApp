//
//  Chat+InjectionKey.swift
//  ChatInterface
//
//  Created by kim sunchul on 11/23/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import DI
import SwiftUI
import Core

public enum ChatHomeViewKey: InjectionKey {
  public typealias Value = View
}


public enum ChatRepositoryKey: InjectionKey {
  public typealias Value = ChatRepositoryType
}


public enum ChatListViewModelKey: InjectionKey {
  public typealias Value = ViewModelType
}
